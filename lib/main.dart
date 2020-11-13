import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/provider.dart';
import 'package:flutter_architecture_starter/screen/main.page.dart';

void main() {
  runApp(AppProvider(page: MainPage()).multiProvider());
}
