import 'package:depature/model/theme_model.dart';
import 'package:flutter/cupertino.dart';

class themeprovider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isDark: false);

  void changetheme() {
    themeModel.isDark = !themeModel.isDark;
    notifyListeners();
  }
}
