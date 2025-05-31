import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class ProfileController with ChangeNotifier{
  late String username;
  late String motivationQuote;
  String? userImagePath;
  bool isLoading = true;

  init() {
    loadData();
  }

  void loadData() async {
    username = PreferencesManager().getString(StorageKey.username) ?? '';
    motivationQuote = PreferencesManager().getString(StorageKey.motivationQuote) ?? "One task at a time. One step closer.";
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    isLoading = false;
    notifyListeners();
  }
  void saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString(StorageKey.userImage, newFile.path);
    notifyListeners();
  }
}