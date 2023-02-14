import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:photosync/scripts/database_manager.dart';
import 'package:photosync/scripts/hivedb_service.dart';
import 'package:photosync/scripts/list_view_of_photos.dart';
import 'package:photosync/scripts/notify.dart';
import 'package:photosync/scripts/sync_manager.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    // openAppSettingsBox();
    await Hive.openBox('appSyncLog');
    await Hive.openBox('appSettings');
    HiveService.addData('appSettings', 'watch_folder',
        '/storage/emulated/0/_ondas.pro/sync_folder/watch_folder');
  } catch (error) {
    notifyAlert(error.toString());
  }
  runApp(const MyApp());

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ondas.Pro PhotoSync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PhotoSync Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    startSyncManager();
    await getWatchFolderDir();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: PhotoGrid()),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.start_outlined),
      ),
    );
  }
}
