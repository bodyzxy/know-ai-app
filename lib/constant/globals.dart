import 'package:know_ai_app/model/menu_options_model.dart';

class Globals {
  static const String defaultLanguage = 'en';

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "zh", value: "中文"), //Chinese
    MenuOptionsModel(key: "de", value: "Deutsche"), //German
    MenuOptionsModel(key: "en", value: "English"), //English
    MenuOptionsModel(key: "es", value: "Español"), //Spanish
    MenuOptionsModel(key: "fr", value: "Français"), //French
    MenuOptionsModel(key: "hi", value: "हिन्दी"), //Hindi
    MenuOptionsModel(key: "ja", value: "日本語"), //Japanese
    MenuOptionsModel(key: "pt", value: "Português"), //Portuguese
    MenuOptionsModel(key: "ru", value: "русский"), //Russian
  ];
}
