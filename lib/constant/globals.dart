import 'package:know_ai_app/model/menu_options_model.dart';

class Globals {
  static const String defaultLanguage = 'en';

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "zh", value: "中文"), //Chinese
    MenuOptionsModel(key: "en", value: "English"), //English
  ];
}
