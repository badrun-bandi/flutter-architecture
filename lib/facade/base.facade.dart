import 'package:flutter/material.dart';

abstract class BaseFacade with ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;
  dynamic error;

  BaseFacade({@required this.context});
}
