import 'dart:ui';

import 'package:flutter_architecture_starter/model/translation.dart';

abstract class LocalizationService {
  Future<Translation> load(Locale locale, {Translation translation});
}
