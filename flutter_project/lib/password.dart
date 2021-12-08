import 'package:flutter/material.dart';

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({Key? key}) : super(key: key);

  @override
  PasswordFormState createState() {
    return PasswordFormState();
  }
}

class PasswordFormState extends State<PasswordForm> {
  //var _usernameController = TextEditingController();
  //String _usernameError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            // controller: _usernameController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your password',
            ),
          ),
        ),
      ],
    );
  }
  /*validate(){
        if(!validateStructure(_usernameController.text)){
            setState(() {
                _usernameError = emailError;
                _passwordError = passwordError;
            });
            // show dialog/snackbar to get user attention.
            return;
        }*/
}
