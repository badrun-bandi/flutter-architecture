import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/screen/widget/text.widget.dart';
import 'package:flutter_architecture_starter/screen/widget/text_form_field.widget.dart';

import '../route.dart';

class LoginPage extends StatelessWidget {
  Future<void> _showHomePage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.home,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(),
              TextFormFieldWidget(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 14,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {
                  _showHomePage(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
