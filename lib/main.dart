// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photosync/functions/s3_upload_button.dart';
import 'package:photosync/functions/watch_manager.dart';
import 'package:photosync/scripts/hivedb_service.dart';
import 'package:photosync/scripts/notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox('photoSyncBox');
    await Hive.openBox('appSettings');
    HiveService.addData('appSettings', 'watch_folder',
        '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder');
  } catch (error) {
    notifyAlert(error.toString());
  }
  runApp(MyApp());

  WidgetsBinding.instance.addObserver(
    HiveShutdownObserver(),
  );
}

class HiveShutdownObserver extends WidgetsBindingObserver {
  @override
  Future<bool> didPopRoute() async {
    await Hive.close();
    return super.didPopRoute();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isWatching = false;
  Watcher? _watcher;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Switch(
                value: _isWatching,
                onChanged: (value) {
                  setState(() {
                    _isWatching = value;
                    if (_isWatching) {
                      _watcher = Watcher();
                      _watcher?.start();
                    } else {
                      _watcher?.stop();
                    }
                  });
                },
              ),
            ),
            Text(_isWatching ? 'Watching' : 'Not Watching'),
            S3UploadButton(),
          ],
        ),
      ),
    );
  }
}
