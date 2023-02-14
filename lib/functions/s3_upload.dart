import 'dart:async';
import 'dart:io';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:photosync/config.dart';
import 'package:photosync/scripts/notify.dart';

Future startS3UploadNow() async {
  notifyAlert("S3 UPLOAD NOW");
  final response = await AwsS3.uploadFile(
      accessKey: configAWSAccessKey,
      secretKey: configAWSSecretKey,
      file: File(
          '/storage/emulated/0/_clicksFloripa/Processed/photo-to-upload.jpg'),
      bucket: "ondaspro",
      region: "sa-east-1",
      destDir: 'testing',
      filename: 'new-photo.jpg',
      contentType: 'image/jpg');
  notifyAlert("S3 RESPONSE: ${response.toString()}");
}
