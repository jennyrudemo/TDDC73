import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({Key? key}) : super(key: key);

  @override
  PasswordFormState createState() {
    return PasswordFormState();
  }
}

class PasswordFormState extends State<PasswordForm> {
  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  var passwordController = TextEditingController();
  String passwordError = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: passwordController,
            //onChanged: validate(),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: 'Enter your password',
                hintText: "Password",
                errorText: passwordError),
          ),
        ),
      ],
    );
  }

  // validate() {
  //   if (!validateStructure(passwordController.text)) {
  //     // show dialog/snackbar to get user attention.

  //     return;
  //   }
  // }
}
