import 'package:photosync/scripts/folder_watcher.dart';
import 'package:photosync/scripts/notify.dart';
import 'package:photosync/scripts/request_storage_permission.dart';

const String watchFolder =
    '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder';

startSyncManager() async {
  notifyAlert("SYNC MANAGER STARTED");

  if (await checkStoragePermissionStatus() == true) {
    if (await checkLocationPermissionStatus() == true) {
      startSyncLoop();
    }
  }
}

Future<bool> checkStoragePermissionStatus() async {
  return await requestStoragePermission();
}

checkLocationPermissionStatus() async {
  return true;
}

startSyncLoop() {
  notifyStatus("SYNC LOOP: ACTIVE");
  startWatchManager();
}

startWatchManager() {
  List newPhotosList = startFolderWatcher(watchFolder);
  return newPhotosList;
}


// IF NEW PHOTOS: NEW HIVEDB ENTRY WITH FILENAME, EXIF DATA,
// UPLOAD PHOTOS TO AWS
// IF SUCCESSFUL UPDATE BUBBLE DATABASE 
// UPDATE HIVE DB


//DISPLAY TO USERS
// OPTION: TO SELECT WATCH FOLDER
// OPTION: TO SELECT BEACH ON MAP
// GRID VIEW OF PHOTOS IN SYNC QUEUE
// START/STOP SWITCH

// LONG PRESS TO SELECT PHOTO FOR TRASH