import 'package:flutter/material.dart';
//import 'package:flutter_password_strength/flutter_password_strength.dart';

class PasswordForm extends StatefulWidget {
  final int minlength;
  final int acceptablelength;
  bool passwordValid = false;

  PasswordForm(
      {Key? key,
      required this.minlength,
      required this.acceptablelength,
      passwordValid})
      : super(key: key);

  @override
  PasswordFormState createState() {
    return PasswordFormState();
  }
}

class PasswordFormState extends State<PasswordForm> {
  // ignore: unused_field
  //late String? _password = "";
  double _strength = 0;

  //String pattern =
  //  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp numExp = RegExp(r".*[0-9].*");
  RegExp letExp = RegExp(r".*[A-Za-z].*");

  String _displayText = "please enter a password";

  var passwordController = TextEditingController();
  String passwordError = "";

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(children: [
                TextField(
                    onChanged: (value) => _checkPassword(value),
                    //controller: passwordController,
                    //onChanged: validate(),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.lightBlue)))),
                const SizedBox(
                  height: 30,
                ),
                LinearProgressIndicator(
                  value: _strength,
                  backgroundColor: Colors.grey[300],
                  color: _strength <= 1 / 4
                      ? Colors.red
                      : _strength == 2 / 4
                          ? Colors.yellow
                          : _strength == 3 / 4
                              ? Colors.blue
                              : Colors.green,
                  minHeight: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(_displayText, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 50,
                ),
              ]))
        ]);
  }

  // void checkOk() {
  //   if (_strength < 1 / 2) {
  //     passwordValid = true;
  //   }
  // }

  void _checkPassword(
    value,
  ) {
    String _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = "Please enter your passwords";
      });
    } else if (_password.length < widget.minlength) {
      setState(() {
        _strength = 1 / 4;
        _displayText = "Your Password is too short";
      });
    } else if (_password.length < widget.acceptablelength) {
      setState(() {
        _strength = 2 / 4;
        _displayText = "Your Password is acceptable but not strong";
        widget.passwordValid = true;
      });
    } else {
      if (!letExp.hasMatch(_password) || !numExp.hasMatch(_password)) {
        setState(() {
          _strength = 3 / 4;
          _displayText = "Your Password is Strong";
          widget.passwordValid = true;
        });
      } else {
        setState(() {
          _strength = 1;
          _displayText = "Your Password is great";
          widget.passwordValid = true;
        });
      }
    }
  }
}
