enum LanguageEnum { english, arabic }

class LanguageEnumHelper {
  static String getLanguageName(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.english:
        return 'en';
      case LanguageEnum.arabic:
        return 'ar';
    }
  }
}
