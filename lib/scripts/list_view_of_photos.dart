import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:photosync/scripts/notify.dart';

class PhotoGrid extends StatefulWidget {
  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  var appSyncLog;

  @override
  void initState() {
    super.initState();
    _openSyncLogBox();
  }

  _openSyncLogBox() async {
    appSyncLog = await Hive.openBox('appSyncLog');

    appSyncLog.watch().listen((event) {
      if (event.key == "ondas_sync_status") {
        setState(() {});
      }
    });
  }

  _refresh() {
    setState(() {
      appSyncLog = null;
      _openSyncLogBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appSyncLog == null) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "No Photos Found",
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _refresh,
              child: Text("Refresh"),
            )
          ],
        ),
      );
    }
    @override
    Widget build(BuildContext context) {
      if (appSyncLog == null) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "No Photos Found",
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _refresh,
                child: Text("Refresh"),
              )
            ],
          ),
        );
      }
      try {
        var syncStatus =
            appSyncLog.get("ondas_sync_status", defaultValue: false);
        return ListView.builder(
          itemCount: appSyncLog.length,
          itemBuilder: (context, index) {
            var key = appSyncLog.keyAt(index);
            var value = appSyncLog.get(key);
            return ListTile(
              title: Text("$key"),
              subtitle: Text("$value"),
            );
          },
        );
      } catch (e) {
        notifyAlert(e.toString());
        return Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "No Photos Found",
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _refresh,
                child: Text("Refresh"),
              )
            ],
          ),
        );
      }
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No Photos Found",
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _refresh,
            child: Text("Refreshs"),
          )
        ],
      ),
    );
  }
}
