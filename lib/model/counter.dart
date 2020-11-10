import 'package:flutter/cupertino.dart';

import 'base.model.dart';

class Counter extends BaseModel {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}