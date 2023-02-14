import 'package:photosync/directory_manager.dart';
// import 'package:photosync/exif_manager.dart';
import 'watch_manager.dart';
import 'file_picker.dart';

Future<void> startSyncManager() async {
  print("start sync manager");

  print("starting file picker");
  selectFolder();

  // // CHECK FOR NEW PHOTOS IN WATCH FOLDER
  // List jpgList = await readFilesInFolder();
  // for (var jpgFile in jpgList) {
  //   print("processing $jpgFile");
  //   String currentPhotoUri = jpgFile.path;
  //   // GET PHOTO ID FROM EXIF DATA
  //   String photoId = await readExifData(currentPhotoUri) as String;

  //   print('photo_id: $photoId');
  //   String? newPhotoName = '$photoId.JPG';
  //   print(newPhotoName);

  //   renameAndOverwriteFile(jpgFile, newPhotoName);

  //   List jpgList2 = await readFilesInFolder();
  //   for (var jpg in jpgList2) {
  //     moveFile(jpg);
  // }

  // RENAME PHOTO TO UNIQUE PHOTO_ID

  // START UPLOADING FILES TO S3

  // ON SUCCESS: POST TO BUBBLE DB

  // SLEEP FOR 1 MINUTE
  // }
}
