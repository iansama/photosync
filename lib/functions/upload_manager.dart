import 'package:hive/hive.dart';
import 'package:photosync/scripts/notify.dart';

uploadManager() async {
  notifyAlert('uploadManager()  :: STARTED');
  // open the Hive box containing your data
  final box = await Hive.openBox('photoSyncBox');

  // run the recurring task every 15 seconds
  while (true) {
    final processedIds = <String>[];
    for (var key in box.keys) {
      final data = box.get(key);
      if (data is Map && data['photo_processed_status'] == true) {
        processedIds.add(key);
      }
    }
    print('Processed IDs: $processedIds');
    notifyAlert('UPLOAD MANAGER :: DELAYED');
    await Future.delayed(Duration(seconds: 15));
  }
}
