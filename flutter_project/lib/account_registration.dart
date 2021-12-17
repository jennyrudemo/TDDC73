import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_project/password.dart';
import 'package:provider/provider.dart';

class AccountRegistration extends StatefulWidget {
  AccountRegistration({
    Key? key,
    this.nameDecoration = defaultNameDec,
    this.usernameDecoration = defaultUsernameDec,
    this.emailDecoration = defaultemailDec,
    this.phoneDecoration = defaultPhoneDec,
    this.genderList = defaultGenderList,
    this.genderLabel = defaultGenderLabel,
    this.passwordDecoration = defaultPasswordDec,
    this.isNameVisible = true,
    this.isGenderVisible = true,
    this.isBirthDateVisible = true,
    this.isEmailVisible = true,
    this.isPhoneNumberVisible = true,
    this.isAgreementCheckVisible = true,
    this.dateHint = defaultDateHint,
    this.birthDateLabel = defaultBirthDateLabel,
    this.agreementText = defaultAgreementText,
    this.buttonText = defaultButtonText,
    //buttonStyle,
    required this.onButtonClick, //The registration form needs to have an onClicked function
  }) : super(key: key);

  //Declartion of variables
  final InputDecoration nameDecoration;
  final InputDecoration usernameDecoration;
  final InputDecoration emailDecoration;
  final InputDecoration phoneDecoration;
  final List<String> genderList;
  final String genderLabel;
  final InputDecoration passwordDecoration;
  //Determine what fields should be shown
  //username and password always visible
  final bool isNameVisible;
  final bool isGenderVisible;
  final bool isBirthDateVisible;
  final bool isEmailVisible;
  final bool isPhoneNumberVisible;
  final bool isAgreementCheckVisible;
  final DateHint dateHint;
  final String birthDateLabel;
  final String agreementText;
  final String buttonText;
  //ButtonStyle buttonStyle;
  void Function() onButtonClick;

  //Default values
  static const InputDecoration defaultNameDec = InputDecoration(
    labelText: 'Full name',
    border: OutlineInputBorder(),
  );
  static const InputDecoration defaultUsernameDec = InputDecoration(
    labelText: 'Username',
    border: OutlineInputBorder(),
  );
  static const InputDecoration defaultemailDec = InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  );
  static const InputDecoration defaultPhoneDec = InputDecoration(
    labelText: 'Phone number',
    border: OutlineInputBorder(),
  );
  static const List<String> defaultGenderList = [
    'Female',
    'Male',
    'Other',
    'Prefer not to say',
  ];
  static const String defaultGenderLabel = 'Gender';
  static const InputDecoration defaultPasswordDec = InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  );
  static const DateHint defaultDateHint = DateHint();
  static const String defaultBirthDateLabel = 'Birth date';
  static const String defaultAgreementText =
      'Default agreement description'; //Text that will be displayed next to checkbox
  static const String defaultButtonText = 'Register';
  // static const ButtonStyle defaultButtonStyle = ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.blue),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );

  @override
  State<AccountRegistration> createState() => _AccountRegistration();
}

class _AccountRegistration extends State<AccountRegistration> {
  //TODO: fix this so it's more general
  //String selectedGender = widget.genderList[0];
  String selectedGender = "Female";
  bool agreementAccepted = false;
  String emailError = "";
  bool emailValid = false;
  bool passwordAccepted = false;
  bool allChecksOK = false;

  Padding name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(decoration: widget.nameDecoration),
    );
  }

  Padding username() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(decoration: widget.usernameDecoration),
    );
  }

  Padding email() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      child: Column(
        children: [
          Text(emailError),
          TextField(
            decoration: widget.emailDecoration,
            onChanged: (email) {
              //Check if email address has valid format
              setState(() {
                if (email.isEmpty) {
                  //emailValid = true;
                } else {
                  emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email);
                }

                if (!emailValid && email.isNotEmpty) {
                  emailError = "Email adress not valid";
                } else {
                  emailError = "";
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Padding phoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: widget.phoneDecoration,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  //Gender picker
  Padding gender() {
    List<String> genders = widget.genderList;

    List<DropdownMenuItem<String>> genderList =
        genders.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.genderLabel),
          DropdownButton(
            value: selectedGender,
            items: genderList,
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  //PLACEHOLDER
  //TODO: use our own implemented password input instead
  /*Padding password() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: widget.passwordDecoration,
      ),
    );
  }*/

  PasswordForm password = PasswordForm(
    minlength: 6,
    acceptablelength: 8,
  );

  //Birth date picker
  Padding birthdatePicker() {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    int startYear = currentYear - 120;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.birthDateLabel),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: DropdownDatePicker(
              firstDate: ValidDate(year: startYear, month: 1, day: 1),
              lastDate: ValidDate(
                  year: currentYear, month: currentMonth, day: currentDay),
              dateHint: widget.dateHint,
              ascending: false,
            ),
          ),
        ],
      ),
    );
  }

  Row checkBoxContainer() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: agreementAccepted,
          onChanged: (bool? value) {
            setState(() {
              agreementAccepted = value!;
              //buttonEnabled = agreementAccepted;
            });
          },
        ),
        Text(widget.agreementText),
      ],
    );
  }

  //Check button
  TextButton checkerButton() {
    if (!widget.isAgreementCheckVisible) {
      agreementAccepted = true;
    }
    if (!widget.isEmailVisible) {
      emailValid = true;
    }

    return TextButton(
      onPressed: () {
        setState(() {
          passwordAccepted = password.passwordValid;
          print(passwordAccepted);

          if (passwordAccepted && emailValid && agreementAccepted) {
            allChecksOK = true;
          } else {
            allChecksOK = false;
          }
        });
      },
      child: Text('Check'),
    );
  }

  //Button
  TextButton registerAccountButton() {
    //If the agreement checkbox is not visible, the accepted variable is assumed true

    return TextButton(
      //TODO: check for both agreement bool and password bool
      onPressed: allChecksOK //&& passwordAccepted
          ? widget.onButtonClick
          : null, //enabled button only if it should be enabled
      child: Text(widget.buttonText),
      //TODO: get button style from constructor

      // style: ButtonStyle(
      //   backgroundColor:
      //       MaterialStateProperty.all(Theme.of(context).primaryColor),
      //   foregroundColor: MaterialStateProperty.all(Colors.white),
      // ),
    );
  }

  Widget accountRegistration() {
    //TODO: replace with actual content
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name field
            //TODO: bättre sätt att returnera inget?
            widget.isNameVisible ? name() : Container(),
            //Gender field
            widget.isGenderVisible ? gender() : Container(),
            //BirthDateField
            widget.isBirthDateVisible ? birthdatePicker() : Container(),
            //Email field
            widget.isEmailVisible ? email() : Container(),
            //Phone number field
            widget.isPhoneNumberVisible ? phoneNumber() : Container(),
            username(),
            password,
            //Agreement checkbox
            widget.isAgreementCheckVisible ? checkBoxContainer() : Container(),
            Row(
              children: [
                checkerButton(),
                registerAccountButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return accountRegistration();
  }
}
