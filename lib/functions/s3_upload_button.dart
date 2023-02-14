import 'package:flutter/material.dart';
import 'package:photosync/functions/aws_manager.dart';
import 'package:photosync/functions/s3_upload.dart';

class S3UploadButton extends StatelessWidget {
  const S3UploadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // await startS3Upload();
          await startS3UploadNow();
        },
        child: Text('Upload to S3'),
      ),
    );
  }
}
