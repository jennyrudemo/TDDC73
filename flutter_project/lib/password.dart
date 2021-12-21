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
  //checkar hur "starkt lösenordet är utifrån void "checkpassword"
  double _styrka = 0;

  RegExp numExp = RegExp(r".*[0-9].*");
  RegExp letExp = RegExp(r".*[A-Za-z].*");

  String _displayText = "please enter a password";

  var passwordController = TextEditingController();
  String passwordError = "";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        //widget för password
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(children: [
                TextField(
                    //läser av input och samtidigt skickar det till checkpassword
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
                            //style för textfield
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.lightBlue)))),
                const SizedBox(
                  height: 30,
                ),
                //själva "styrka-,mätaren",
                //visar utifrån vad checkpassword har för strength hur mycket ifylld "LinearProgressIndicator" kommer vara
                //denna baseras också på "value" som är inputen
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
                  height: 20,
                ),
                Text(_displayText, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 50,
                ),
              ]))
        ]);
  }

  void _checkPassword(
    value,
  ) {
    //tar in inputen men räknar inte med whitespace
    String _password = value.trim();

// conditions för vilket meddelande som kommer att visas för lösenordet, baserat på styrka
// i passwordvalid ändras widgetens "värde" baserat på om lösenordet är accepterat eller inte
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
