import 'package:path_provider/path_provider.dart';

Future<String> getDCIMDirectory() async {
  final directory = await getExternalStorageDirectory();
  return '${directory!.path}/DCIM/';
}
