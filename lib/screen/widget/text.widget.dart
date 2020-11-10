import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'LOGIN',
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
