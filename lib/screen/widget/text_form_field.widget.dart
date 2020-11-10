import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Username',
      ),
    );
  }
}
