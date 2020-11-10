import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screen/widget/text_form_field.widget.dart';
import 'package:flutter_boilerplate/screen/widget/text.widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
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
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
