import 'package:flutter/material.dart';


class LoadingManager {
  factory LoadingManager() => _instance;

  LoadingManager._();

  static final LoadingManager _instance = LoadingManager._();

  int showCount = 0;

  void show(BuildContext context) {
    if (showCount == 0) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
              onWillPop: () async{
                return await true;
              },
              child: const Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,))),
        );
        showCount++;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void hide(BuildContext context) {
    if (showCount == 1) {
      Navigator.pop(context);
    } else if (showCount <= 1) {
      return;
    }
    showCount--;
  }
}
