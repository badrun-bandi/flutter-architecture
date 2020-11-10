import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/provider.dart';
import 'package:flutter_boilerplate/screen/main.page.dart';

void main() {
  runApp(AppProvider(page: MainPage()).multiProvider());
}
