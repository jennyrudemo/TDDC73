import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  //input variables
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
  // "_styrka" checks how strong the password, from void function checkpassword
  double _styrka = 0;

  //expression for any numbers
  RegExp numExp = RegExp(r".*[0-9].*");
  //expression for any lower or upper characters
  RegExp letExp = RegExp(r".*[A-Za-z].*");

  //default display text
  String _displayText = "please enter a password";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        //widget for password
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(children: [
                TextField(
                    //reads input and sends to checkpassword meantime
                    onChanged: (value) {
                      _checkPassword(value);
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                            //style for borders
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.lightBlue)))),

                const SizedBox(
                  //creates space between password and strengthmeter
                  height: 30,
                ),
                //the strength meter
                //displays what strength password has from checkpassword
                //depends on the input "value"
                LinearProgressIndicator(
                  value: _styrka,
                  backgroundColor: Colors.grey[300],
                  color: _styrka <= 1 / 4
                      ? Colors.red
                      : _styrka == 2 / 4
                          ? Colors.yellow
                          : _styrka == 3 / 4
                              ? Colors.blue
                              : Colors.green,
                  minHeight: 15,
                ),
                const SizedBox(
                  //creates space between strengthmeter and text
                  height: 20,
                ),
                Text(_displayText, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 50,
                ),
              ]))
        ]);
  }

  void _checkPassword(value) {
    // takes input argument and trims (removes whitespace)
    String _password = value.trim();

// conditions for what message will be displayed and the size of styrka
// will be set as acceptable to register if conditions fulfill 2/4
    if (_password.isEmpty) {
      setState(() {
        _styrka = 0;
        _displayText = "Please enter your passwords";
        widget.passwordValid = false;
      });
    } else if (_password.length < widget.minlength) {
      setState(() {
        _styrka = 1 / 4;
        _displayText = "Your Password is too short";
        widget.passwordValid = false;
      });
    } else if (_password.length < widget.acceptablelength) {
      setState(() {
        _styrka = 2 / 4;
        _displayText = "Your Password is acceptable but not strong";
        widget.passwordValid = true;
      });
    } else {
      if (!letExp.hasMatch(_password) || !numExp.hasMatch(_password)) {
        setState(() {
          _styrka = 3 / 4;
          _displayText = "Your Password is Strong";
          widget.passwordValid = true;
        });
      } else {
        setState(() {
          _styrka = 1;
          _displayText = "Your Password is great";
          widget.passwordValid = true;
        });
      }
    }
  }
}
