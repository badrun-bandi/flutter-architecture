import 'package:flutter/material.dart';

final TextEditingController textFormFieldController =
    new TextEditingController();

class TextFormFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFormFieldController,
      decoration: InputDecoration(
        hintText: 'Username',
      ),
    );
  }
}
