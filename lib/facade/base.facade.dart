
import 'package:flutter/foundation.dart';

abstract class BaseFacade with ChangeNotifier implements Listenable {
  bool isLoading = false;
  dynamic error;
  BaseFacade();
}
