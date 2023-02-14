import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:photosync/config.dart';
import 'package:photosync/scripts/notify.dart';

void generateThumbnails(String photoURI) {
  // Load the original image
  List<int> imageBytes = File(photoURI).readAsBytesSync();
  Uint8List uint8List = Uint8List.fromList(imageBytes);
  Image? originalImage = decodeImage(uint8List);

  // Create three smaller versions of the image with different sizes
  var smallImage = copyResize(originalImage!, width: 400, height: 300);
  var mediumImage = copyResize(originalImage, width: 800, height: 600);
  var largeImage = copyResize(originalImage, width: 1200, height: 900);

  // Save the resized images
  File(getThumbnailURI(photoURI, 'small'))
      .writeAsBytesSync(encodeJpg(smallImage));
  File(getThumbnailURI(photoURI, 'medium'))
      .writeAsBytesSync(encodeJpg(mediumImage));
  File(getThumbnailURI(photoURI, 'large'))
      .writeAsBytesSync(encodeJpg(largeImage));
}

getThumbnailURI(String photoURI, String size) {
  Uri uri = Uri.parse(photoURI);
  String fileName = uri.pathSegments.last;
  String photoID = fileName.replaceAll(".jpg", "");
  String newthumbURI = '$thumbsFolder/$photoID-$size.jpg';
  notifyAlert(newthumbURI);
  return newthumbURI;
}
