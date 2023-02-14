import 'dart:io';
import 'package:http/http.dart' as http;

Future<bool> s3Uploader(File file, String presignedUrl) async {
  final request = http.MultipartRequest('PUT', Uri.parse(presignedUrl));
  final fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
  final fileLength = await file.length();

  request.files.add(http.MultipartFile('file', fileStream, fileLength));

  final response = await request.send();
  return response.statusCode == 200;
}
