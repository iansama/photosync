import 'package:permission_handler/permission_handler.dart';
import 'package:photosync/directory_manager.dart';
import 'watch_manager.dart';
import 'hivedb_manager.dart';
// import 'exif_manager.dart';
import 'sync_manager.dart';

Future<void> _requestStoragePermission() async {
  /// Snippet when user clicks on download second time
  // String watchDirectory = '/storage/0000-0000/DCIM/100D3200';
  String watchDirectory =
      '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder';
  final permission = Permission.storage;
  final status = await permission.status;
  print('>>>Status $status');

  /// here it is coming as PermissionStatus.granted
  if (status != PermissionStatus.granted) {
    await permission.request();
    if (await permission.status.isGranted) {
      ///perform other stuff to download file
      // readFilesInFolder();
      print("--");
    } else {
      await permission.request();
    }
    print('>>> ${await permission.status}');
  }
  startSyncManager();
  // final data = {'photoid': '123', 'albumid': 'abc123'};
  // putInHiveDB();
  // getFromHive();
  // renameFile();
  // readExifData('/storage/0000-0000/DCIM/100D3200/DSC_1023.JPG');

  ///perform other stuff to download file
  ///
}
