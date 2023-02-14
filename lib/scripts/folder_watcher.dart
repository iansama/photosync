import 'dart:io';

import 'package:photosync/scripts/get_default_dcim_dir.dart';
import 'package:photosync/scripts/notify.dart';

startFolderWatcher(String folderPath) {
  notifyStatus(" START FOLDER WATCHER");
  final folder = Directory(folderPath);

  // List the initial files in the directory
  List<FileSystemEntity> initialFiles = folder.listSync();
  List<String> newPhotos = [];

  // List the initial files in the directory
  print('Initial files:');
  print('-------------------------------------------------------');
  initialFiles.forEach((file) {
    print(file.path);
  });
  print('-------------------------------------------------------');

  // Listen for changes to the directory
  folder.watch().listen((FileSystemEvent event) {
    if (event.type == FileSystemEvent.modify) {
      // List the updated files in the directory
      List<FileSystemEntity> updatedFiles = folder.listSync();

      // Find the new photos added to the directory
      for (var file in updatedFiles) {
        if (!initialFiles.contains(file)) {
          if (file is File && file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg') ||
              file.path.endsWith('.png')) {
            newPhotos.add(file.path);
          }
        }
      }

      // Update the initial files list
      initialFiles = updatedFiles;
      print('------- $initialFiles');
    }
  });

  return newPhotos;
}
