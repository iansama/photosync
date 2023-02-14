import 'package:file_picker/file_picker.dart';

Future<String> selectFolder() async {
  try {
    String? selectedPath = await FilePicker.platform.getDirectoryPath();
    if (selectedPath != null && selectedPath.isNotEmpty) {
      print("============ path selected is : $selectedPath");
      return selectedPath;
    } else {
      return "";
    }
  } catch (e) {
    print("Error selecting folder: $e");
    return Future.error(e);
  }
}
