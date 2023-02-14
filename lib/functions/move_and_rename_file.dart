import 'dart:io';

import 'package:photosync/functions/thumbnail_generator.dart';

import '../scripts/hivedb_service.dart';
import '../scripts/notify.dart';

Future<void> moveAndRenameFile(
    String sourcePath, String destinationPath) async {
  notifyAlert(" MOVING AND RENAMING FILE");
  notifyAlert(" sourcePath :: $sourcePath");
  notifyAlert(" destinationPath :: $destinationPath ");

  File file = File(sourcePath);
  if (!file.existsSync()) {
    throw FileSystemException('File does not exist: $sourcePath');
  }

  File destinationFile = File(destinationPath);
  if (destinationFile.existsSync()) {
    try {
      await destinationFile.delete();
    } catch (e) {
      throw FileSystemException(
          notifyAlert("FAILED TO DELETE EXISITING FILE: $destinationPath"));
    }
  }

  try {
    await file.rename(destinationPath);
    generateThumbnails(destinationPath);
  } catch (e) {
    throw FileSystemException('Failed to move and rename file: $sourcePath');
  }
}
