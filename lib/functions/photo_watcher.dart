import 'dart:async';
import 'dart:io';
import 'package:photosync/functions/file_manager.dart';
import 'package:photosync/functions/get_exif_data.dart';
import 'package:photosync/scripts/notify.dart';

class PhotoWatcher {
  List<File> newPhotos = [];
  List<String> newPhotosURIsList = [];
  Directory directory =
      Directory('/storage/emulated/0/_ondas.pro/sync_folder/watch_folder');
  StreamSubscription? subscription;

  void start() async {
    notifyStatus('WATCHER STARTED');
    FileSystemEntityType type = await FileSystemEntity.type(directory.path);

    if (type == FileSystemEntityType.notFound) {
      print('The specified directory does not exist.');
    } else if (type == FileSystemEntityType.directory) {
      var watcher = directory.watch();
      subscription = watcher.asBroadcastStream().listen((event) async {
        if (event.type == FileSystemEvent.create) {
          File file = File(event.path);
          if (file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg') ||
              file.path.endsWith('.JPG') ||
              file.path.endsWith('.JPEG')) {
            await _processNewPhoto(file);
          }
        }
      });
    }
  }

  void stop() {
    subscription?.cancel();
  }

  Future<void> _processNewPhoto(File file) async {
    // newPhotosURIsList.add(file.path);
    // notifyAlert('New photo found: ${file XX.path}');
    // getNewPhotoIDFromExif(file.path);
    // startFileProcessingManager(newPhotosURIsList);
    startFileProcessingManager(file.path);
  }
}
