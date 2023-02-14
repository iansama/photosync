import 'package:permission_handler/permission_handler.dart';
import 'package:photosync/scripts/notify.dart';

Future<bool> requestStoragePermission() async {
  notifyStatus("REQUESTING STORAGE PERMISSIONS");
  const permission = Permission.storage;
  final status = await permission.status;

  if (status == PermissionStatus.granted) {
    notifyStatus("** STORAGE PERMISSION: GRANTED **");
    return true;
  } else if (status == PermissionStatus.denied) {
    notifyStatus("!! !! STORAGE PERMISSION: DENIED !! !!");
    return false;
  } else {
    notifyStatus("!! !! STORAGE: REQUESTING PERMISSION !! !!");
    final result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
