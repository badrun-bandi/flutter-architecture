import 'dart:ui';

class CommonUtils {
  /// Emit a [info] log event
  static void printInfo(String info) {
    print('\u001b[32m[INFO]: $info\u001b[0m');
  }

  /// Emit a [warning] log event
  static void printWarning(String warning) {
    print('\u001B[34m[WARNING]: $warning\u001b[0m');
  }

  /// Emit a [error] log event
  static void printError(String error) {
    print('\u001b[31m[ERROR]: $error\u001b[0m');
  }

  /// Convert string locale [localeString] to [Locale]
  static Locale localeFromString(String localeString) {
    final localeList = localeString.split('_');
    switch (localeList.length) {
      case 2:
        return Locale(localeList.first, localeList.last);
      case 3:
        return Locale.fromSubtags(
            languageCode: localeList.first,
            scriptCode: localeList[1],
            countryCode: localeList.last);
      default:
        return Locale(localeList.first);
    }
  }

  /// Convert [locale] to Srting with custom [separator]
  static String localeToString(Locale locale, {String separator = '_'}) {
    return locale.toString().split('_').join(separator);
  }
}
