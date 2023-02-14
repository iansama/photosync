import 'package:hive/hive.dart';
import 'package:photosync/scripts/notify.dart';

class HiveService {
  static Future<Box> openBox(String boxName) async {
    try {
      var box = await Hive.openBox(boxName);
      notifyStatus('[ HIVE BOX OPENED :: $boxName :: ]');
      return box;
    } catch (error) {
      notifyAlert(error.toString());
      throw error;
    } finally {
      // Clean up resources if necessary
    }
  }

  static Future<void> addData(
      String boxName, dynamic key, dynamic value) async {
    var box = await openBox(boxName);
    await box.put(key, value);
  }

  static Future<dynamic> readData(String boxName, dynamic key) async {
    var box = await openBox(boxName);
    var value = box.get(key);
    notifyAlert("--[ HIVEDB]-- :: -- ($boxName) $key : $value");
    return value;
  }

  static Future<void> updateData(
      String boxName, dynamic key, dynamic value) async {
    var box = await openBox(boxName);
    box.put(key, value);
  }

  static Future<void> deleteData(String boxName, dynamic key) async {
    var box = await openBox(boxName);
    box.delete(key);
  }

  Future<void> addPhotoToHive(String photoID, String photoURI) async {
    var box = await openBox('photoSyncBox');
    var entry = hiveEntryMap;
    entry['photo_id'] = photoID;
    entry['photo_processed_status'] = true;
    entry['uri_hq'] = photoURI;
    await box.put(photoID, entry);
    entry.forEach((key, value) {
      notifyAlert('$key: $value');
    });
  }
}

Map hiveEntryMap = {
  'seller_id': '',
  'photo_id': '',
  'album_id': '',
  'filename': '',
  'uri_hq': '',
  'uri_thumb_large': '',
  'uri_thumb_medium': '',
  'uri_thumb_small': '',
  'exif_data': {},
  'date_photo_taken': '',
  'timestamp_string': '',
  'photo_processed_status': false,
  's3_sync_status': false,
  'bubbledb_sync_status': false,
  'url_hq': '',
  'url_thumb_large': '',
  'url_thumb_medium': '',
  'url_thumb_small': '',
  'position_latitude': 0.0,
  'position_longitude': 0.0,
};
