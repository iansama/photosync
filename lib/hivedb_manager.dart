import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

String photoDataBoxName = "box";

Future<void> startHiveDB() async {
  // Get the internal storage directory
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  // Initialize Hive with the internal storage directory
  Hive.init(appDocumentDirectory.path);
}

Future<void> putInHiveDB() async {
  await startHiveDB();

  final data = {'photoid': '123', 'albumid': 'abc123'};

  // Open the box where data will be stored
  final box = await Hive.openBox(photoDataBoxName);

  // Add data to the box
  await box.put('photoid', '123568');

  // Close the box when it is no longer needed
  await box.close();
}

Future<void> getFromHive() async {
  await startHiveDB();
  // Open the box where data will be stored
  final box = await Hive.openBox(photoDataBoxName);

  // Get data from the box
  final value = box.get('photoid');
  print(value);

  // Close the box when it is no longer needed
  await box.close();
}

Future<void> deleteFromHive() async {
  await startHiveDB();

  // Open the box where data will be stored
  final box = await Hive.openBox(photoDataBoxName);

  // Delete data from the box
  await box.delete('key');

  // Close the box when it is no longer needed
  await box.close();
}
