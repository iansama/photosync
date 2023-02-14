import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:photosync/scripts/notify.dart';

import '../config.dart';

Future<void> startS3Upload() async {
  final accessKey = configAWSAccessKey;
  final secretKey = configAWSSecretKey;
  const region = 'sa-east-1';
  const bucketName = 'ondaspro';
  final objectKey = 'fluttertest/photo-uploaded.jpg';
  final expiration = DateTime.now().add(Duration(hours: 1));

  final url = generatePresignedUrl(
    'PUT',
    bucketName,
    objectKey,
    region,
    accessKey,
    secretKey,
    expiration,
  );

  final file =
      File('/storage/emulated/0/_clicksFloripa/Processed/photo-to-upload.jpg');
  final bytes = await file.readAsBytes();
  final response = await http.put(Uri.parse(url), body: bytes);
  if (response.statusCode == 200) {
    print('Upload successful!');
  } else {
    print('Upload failed with status code ${response.statusCode}');
  }
}

String generatePresignedUrl(
  String method,
  String bucketName,
  String objectKey,
  String region,
  String accessKey,
  String secretKey,
  DateTime expiration,
) {
  final formattedDateTime =
      DateFormat(DateTime.now().toString()).format(expiration);
  final host = '$bucketName.s3.$region.amazonaws.com';
  final path = '/$objectKey';
  final queryParams = 'X-Amz-Algorithm=AWS4-HMAC-SHA256'
      '&X-Amz-Credential=$accessKey/$formattedDateTime/$region/s3/aws4_request'
      '&X-Amz-Date=$formattedDateTime'
      '&X-Amz-Expires=3600'
      '&X-Amz-SignedHeaders=host';

  final canonicalRequest =
      '$method\n$path\n$queryParams\nhost:$host\n\nhost\nUNSIGNED-PAYLOAD';
  final credentialScope = '$formattedDateTime/$region/s3/aws4_request';
  final stringToSign =
      'AWS4-HMAC-SHA256\n$formattedDateTime\n$credentialScope\n${sha256.convert(utf8.encode(canonicalRequest))}';
  final signingKey =
      generateSigningKey(secretKey, formattedDateTime, region, 's3');
  final signature = hmacSha256(stringToSign, signingKey);
  String finalPresignedURL =
      'https://$host$path?$queryParams&X-Amz-Signature=$signature';

  notifyAlert(finalPresignedURL);
  return finalPresignedURL;
}

List<int> hmacSha256(String data, List<int> key) {
  final hmac = Hmac(sha256, key);
  return hmac.convert(utf8.encode(data)).bytes;
}

List<int> generateSigningKey(
    String secretKey, String dateStamp, String regionName, String serviceName) {
  final kDate = hmacSha256(dateStamp, utf8.encode('AWS4$secretKey'));
  final kRegion = hmacSha256(regionName, kDate);
  final kService = hmacSha256(serviceName, kRegion);
  final kSigning = hmacSha256('aws4_request', kService);
  return kSigning;
}
