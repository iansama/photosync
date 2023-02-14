import 'dart:async';
import 'dart:io';
import 'package:photosync/functions/file_manager.dart';
import 'package:photosync/functions/sync_manager.dart';
import 'package:photosync/functions/upload_manager.dart';
import 'package:photosync/scripts/notify.dart';

class Watcher {
  List<File> newPhotos = [];
  List<String> newPhotosURIsList = [];
  Directory directory = Directory(watchFolder);
  Timer? timer;

  void start() async {
    notifyStatus('WATCHER STARTED');
    startSyncManager();
    FileSystemEntityType type = await FileSystemEntity.type(directory.path);
    if (type == FileSystemEntityType.notFound) {
      print('The specified directory does not exist.');
    } else if (type == FileSystemEntityType.directory) {
      timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
        notifyAlert('Checking for new photos in ${directory.path}...');
        for (var i = 15; i > 0; i--) {
          print('Checking in $i seconds...');
          await Future.delayed(const Duration(seconds: 1));
        }
        var files = directory.listSync();
        for (var file in files) {
          if (file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg') ||
              file.path.endsWith('.JPG') ||
              file.path.endsWith('.JPEG')) {
            if (file is File) {
              await _processNewPhoto(file);
            }
          }
        }
      });
    }
  }

  void stop() {
    notifyStatus('WATCHER STOPPED');
    timer?.cancel();
  }

  Future<void> _processNewPhoto(File file) async {
    await startFileProcessingManager(file.path);
  }
}
