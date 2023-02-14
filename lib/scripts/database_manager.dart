import 'package:photosync/scripts/hivedb_service.dart';
import 'package:photosync/scripts/notify.dart';

void openAppSettingsBox() async {
  await HiveService.openBox('appSettings');
  notifyAlert("appSettingsBox opened successfully.");
}

Future<String> getWatchFolderDir() async {
  String dir = await HiveService.readData('appSettings', "watch_folder");
  return dir;
}
