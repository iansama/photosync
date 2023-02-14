import 'dart:io';
import 'config.dart';

readFilesInFolder() async {
  String folderPath = watchFolder;
  final directory = Directory(folderPath);

  if (directory.existsSync()) {
    final files = directory.listSync();
    List<File> jpgFiles = [];
    for (var file in files) {
      if (file is File && file.path.endsWith('.JPG')) {
        jpgFiles.add(file);
      }
      return jpgFiles;
    }

    if (jpgFiles.isNotEmpty) {
      print('Found ${jpgFiles.length} .JPG files:');

      return jpgFiles;
    } else {
      print('No .JPG files found in ${directory.path}');
      print(jpgFiles);
      return jpgFiles;
    }
  } else {
    print('Directory does not exist: ${directory.path}');
  }
}
