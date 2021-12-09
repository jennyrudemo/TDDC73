import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';

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
  //@override
  //AccountRegistration get widget;

  //TODO: fix this so it's more general
  //String selectedGender = widget.genderList[0];
  String selectedGender = "Female";
  int selectedYear = DateTime.now().year;
  //String selectedMonth = 'Jan';
  //String selectedDay = '1';
  bool agreementAccepted = false;
  bool buttonEnabled = false; //TODO: endast false om checkbox finns

  TextField name() {
    return TextField(decoration: widget.nameDecoration);
  }

  //TODO: behöver vi använda TextFormField (till skillnad från TextField)?
  TextField username() {
    return TextField(decoration: widget.usernameDecoration);
  }

  //TODO: implement email validator
  //Make more general
  /*TextFormField email() {
    return TextFormField(
      validator: (value) =>
          EmailValidator.validate(value) ? null : "Please enter a valid email",
    );
  }*/

  TextField email() {
    return TextField(decoration: widget.emailDecoration);
  }

  //TODO: require numbers
  TextField phoneNumber() {
    return TextField(decoration: widget.phoneDecoration);
  }

  //Gender picker
  Column gender() {
    List<String> genders = widget.genderList;

    List<DropdownMenuItem<String>> genderList =
        genders.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return Column(
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
        ),
      ],
    );
  }

  //PLACEHOLDER
  //TODO: use our own implemented password input instead
  TextField password() {
    return TextField(
      decoration: widget.passwordDecoration,
    );
  }

  //Birth date picker
  Column birthdatePicker() {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    int startYear = currentYear - 120;

    return Column(
      children: [
        Text(widget.birthDateLabel),
        DropdownDatePicker(
          firstDate: ValidDate(year: startYear, month: 1, day: 1),
          lastDate: ValidDate(
              year: currentYear, month: currentMonth, day: currentDay),
          dateHint: widget.dateHint,
          ascending: false,
        ),
      ],
    );
  }

  Row checkBoxContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: agreementAccepted,
          onChanged: (bool? value) {
            setState(() {
              agreementAccepted = value!;
              buttonEnabled = agreementAccepted;
            });
          },
        ),
        Text(widget.agreementText),
      ],
    );
  }

  //Button
  TextButton registerAccountButton() {
    return TextButton(
      onPressed: buttonEnabled
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          name(),
          username(),
          email(),
          phoneNumber(),
          gender(),
          password(),
          birthdatePicker(),
          checkBoxContainer(),
          registerAccountButton(),
          //Button to register
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return accountRegistration();
  }
}
