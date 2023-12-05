import 'package:depature/model/language_model.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Model model = Model(ishindi: false);

  void changelanguage() {
    model.ishindi = !model.ishindi;
  }
}
