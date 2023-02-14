import 'dart:io';
import 'config.dart';

import 'package:path/path.dart';

Future<void> listFilesInDirectory(String directoryPath) async {
  Directory directory = Directory(directoryPath);

  if (await directory.exists()) {
    List<FileSystemEntity> files =
        directory.listSync(followLinks: false, recursive: false);

    for (FileSystemEntity file in files) {
      print(file.path);
    }
  } else {
    print("The directory does not exist.");
  }
}

// Future<void> renameFile(String oldPath, String newPath) async {
Future<void> renameFile() async {
  String oldPath =
      '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder/DSC_0002.JPG';
  String newPath =
      '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder/ian0_15691_1156985_0002.JPG';
  final file = File(oldPath);

  await file.rename(newPath);
  print('File renamed from $oldPath to $newPath');
}

Future<void> renameAndOverwriteFile(File file, String newName) async {
  String path = file.path;
  String newPath = path.substring(0, path.lastIndexOf("/") + 1) + newName;
  try {
    print("-- renaming --");
    await file.rename(newPath);
  } on FileSystemException catch (e) {
    print(e);
    if (e.message.contains("File exists")) {
      await file.delete();
      await file.rename(newPath);
    }
  }
  print("-- renaming complete --");
}

getNewPhotoUri(String originalFilePath, String photoId) async {
// String originalFilePath = "/path/to/original/file.jpg";
// String newFileName = "new_file.jpg";

// Split the file path into the directory and file name
  int lastSlashIndex = originalFilePath.lastIndexOf("/");
  String directory = originalFilePath.substring(0, lastSlashIndex + 1);
  String originalFileName = originalFilePath.substring(lastSlashIndex + 1);

// Replace the file name in the original file path with the new file name
  String newFilePath = directory + photoId + ".JPG";

  // print(newFilePath);
// Output: /path/to/original/new_file.jpg
  return newFilePath;
}

Future<void> moveFile(File filePath) async {
  String newFolderPath = '/storage/emulated/0/_ondas.pro/sync_folder/hq_folder';

  String directory = "/path/to/your/file.txt";
  String photoName = basename(filePath.path);
  print(photoName);

  final file = filePath;
  final newFile = File(newFolderPath + '/' + photoName);
  if (await newFile.exists()) {
    await newFile.delete();
  }
  await file.copy(newFile.path);
  await file.delete();
}

getFileNameFromURI() {}
