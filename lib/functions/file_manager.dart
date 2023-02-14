// THIS FILE HANDLES THE FILE PROCESSING / DEVICE PROCESSING

// GET A LIST OF NEW PHOTOS
import 'package:hive/hive.dart';
import 'package:photosync/functions/get_exif_data.dart';
import 'package:photosync/functions/move_and_rename_file.dart';
import 'package:photosync/scripts/notify.dart';
import 'package:photosync/scripts/hivedb_service.dart';

String workingDirectory = '/storage/emulated/0/_ondas.pro/sync_folder';
String hqFolder = '$workingDirectory/hq_folder';
String watchFolder = '$workingDirectory/watch_folder';
String thumbnailFolder = '$workingDirectory/thumbs_folder';

startFileProcessingManager(String currentPhotoURI) {
  notifyAlert("START PROCESSING MANAGER");
  startProcessingLoop(currentPhotoURI);
}

startProcessingLoop(String currentPhotoURI) async {
  notifyAlert("START PROCESSING LOOP");

  // for (String currentPhotoURI in newPhotoURIsList) {
  notifyStatus("PROCESSING PHOTO_URI: $currentPhotoURI");

  // GET PHOTO_ID FROM EXIF
  String photoID = await getNewPhotoIDFromExif(currentPhotoURI);

  // MAKE PHOTO FILENAME FROM PHOTO ID
  String photoFileName = "$photoID.jpg";

  // MAKE NEW FILE DESTINATION URI
  String hqFileDestinationURI = '$hqFolder/$photoFileName';

  // MOVE PHOTO TO SYNC FOLDER AND RENAME WITH PHOTO ID
  moveAndRenameFile(currentPhotoURI, hqFileDestinationURI);

  // MAKE 3 RESIZE VERSIONS
  // generateThumbnails(hqFileDestinationURI);
  HiveService().addPhotoToHive(photoID, hqFileDestinationURI);

  // checkBoxInfo();
}

checkBoxInfo() {
  final box = Hive.box('photoSyncBox');
  final allEntries = box.toMap();

  if (allEntries.isNotEmpty) {
    print('All entries in the box:');
    allEntries.forEach((key, value) {
      print('$key: $value');
    });
  } else {
    print('The box is empty');
  }
}

// DUMP ALL DATA TO HIVEDB

// MARK HIVEDB KEY [PROCESSED_STATUS AS TRUE]

// ITERATE TO NEXT ITEM