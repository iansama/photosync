import 'dart:async';

import 'package:hive/hive.dart';
import 'package:photosync/scripts/notify.dart';

bool isProcessing = false;
startSyncManager() {
  notifyStatus(' S3 MANAGER STARTED');
  // Initialize the Hive box
  final box = Hive.box('photoSyncBox');

  // Call the callback function immediately before starting the periodic timer
  Timer.run(() async {
    await checkAndSyncPhotos(box);
  });

  // Set up a timer to check for the key-value pairs every 15 seconds
  Timer.periodic(Duration(seconds: 15), (Timer t) async {
    await checkAndSyncPhotos(box);
  });
}

Future<void> checkAndSyncPhotos(Box box) async {
  notifyAlert(' [ S3_SYNC CHECK STARTED]');

  // Check if the function is currently running; if so, return without doing anything
  if (isProcessing) {
    return;
  }

  // Set the isProcessing variable to true to indicate that the function is now running
  isProcessing = true;

  for (var key in box.keys) {
    final photo = box.get(key);
    if (photo['photo_processed_status'] == true &&
        photo['s3_sync_status'] == false) {
      // Perform the necessary actions for the photo here
      // For example, you can upload the photo to S3
      notifyAlert(key);
      bool uploadSuccessful = await uploadPhotoToS3();
      if (uploadSuccessful) {
        photo['s3_sync'] = true;
        box.put(key, photo);
      }
    }
  }

  // Set the isProcessing variable to false to indicate that the function has finished running
  isProcessing = false;
}

// Function to upload the photo to S3
// Future<bool> uploadPhotoToS3(Map<String, dynamic> photo) async {
Future<bool> uploadPhotoToS3() async {
  // Implementation of S3 upload logic goes here
  // Return true if upload was successful, false otherwise
  for (var i = 60; i >= 0; i--) {
    print(' [ FINAL COUNTDOWN ] :: $i SECONDS');
    await Future.delayed(Duration(seconds: 1));
  }
  notifyAlert(" [uploadPhotoToS3] :: RETURNING FALSE ");
  return false;
}
