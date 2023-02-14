import 'package:exif/exif.dart';
import 'package:exif/exif.dart' show readExifFromBytes, IfdTag;
import 'dart:io';

import 'package:photosync/scripts/notify.dart';

String userAlias = "ondaspro-clicksfloripa";

Future readExifData(String photoURI) async {
  Map<String, IfdTag> exifData =
      await readExifFromBytes(await File(photoURI).readAsBytes());

  exifData.forEach((String tag, IfdTag value) {
    print('$tag: ${value.toString()}');
  });
}

Future getNewPhotoIDFromExif(String photoURI) async {
  Map<String, IfdTag> exifData =
      await readExifFromBytes(await File(photoURI).readAsBytes());

  String? dateDigitized = exifData['EXIF DateTimeDigitized'].toString();
  String? subSecond = exifData['EXIF SubSecTimeDigitized'].toString();

  String stripeString1 = dateDigitized.replaceAll(RegExp(r" "), "-");
  String stripeString2 = stripeString1.replaceAll(RegExp(r":"), "");

  String newPhotoID = "$userAlias-$stripeString2$subSecond";

  notifyStatus('DATE TAKEN :: $newPhotoID');
  return newPhotoID;
}

Future getRawExifData(String photoURI) async {
  Map<String, IfdTag> exifData =
      await readExifFromBytes(await File(photoURI).readAsBytes());

  return exifData;
}
