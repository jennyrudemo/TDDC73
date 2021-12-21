import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart'; //not null-safe, which is not ideal
import 'package:flutter_project/password.dart';

class AccountRegistration extends StatefulWidget {
  //Constructor
  const AccountRegistration({
    Key? key,
    this.nameDecoration = defaultNameDec,
    this.usernameDecoration = defaultUsernameDec,
    this.emailDecoration = defaultemailDec,
    this.phoneDecoration = defaultPhoneDec,
    this.genderList = defaultGenderList,
    this.genderLabel = defaultGenderLabel,
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
    required this.onButtonClick, //Called to finilize the registration
  }) : super(key: key);

  //Declartion of variables
  //Defines appearance of text input fields
  final InputDecoration nameDecoration;
  final InputDecoration usernameDecoration;
  final InputDecoration emailDecoration;
  final InputDecoration phoneDecoration;

  //Variables to determine what fields should be shown
  //username and password always visible
  final bool isNameVisible;
  final bool isGenderVisible;
  final bool isBirthDateVisible;
  final bool isEmailVisible;
  final bool isPhoneNumberVisible;
  final bool isAgreementCheckVisible;

  //Labels and hints
  final DateHint dateHint;
  final String birthDateLabel;
  final String agreementText;
  final String buttonText; //Text for registration button
  final List<String> genderList;
  final String genderLabel;

  //Function called when finilizing registration
  final void Function() onButtonClick;

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
  static const DateHint defaultDateHint = DateHint();
  static const String defaultBirthDateLabel = 'Birth date';
  static const String defaultAgreementText =
      'Default agreement description'; //Text that will be displayed next to checkbox
  static const String defaultButtonText = 'Register';

  @override
  State<AccountRegistration> createState() => _AccountRegistration();
}

class _AccountRegistration extends State<AccountRegistration> {
  //Declare variables and set initial values
  String selectedGender = "";
  bool agreementAccepted = false;
  String emailError = "";
  bool emailValid = false;
  bool passwordAccepted = false;
  bool allChecksOK = false;

  //Variable for the password field
  PasswordForm password = PasswordForm(
    minlength: 6,
    acceptablelength: 8,
  );

  //Sets the default value of the gender dropdown list to the first item of the
  //list of genders
  @override
  void initState() {
    selectedGender = widget.genderList[0];
  }

  //Function to create the input field for a person's name
  Padding name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(decoration: widget.nameDecoration),
    );
  }

  //Function to create the input field for a person's username
  Padding username() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(decoration: widget.usernameDecoration),
    );
  }

  //Function to create the input field for a person's email address
  //When text is typed, a check is performed to see if the input matches the
  //email address format. If it does not, an error message is set, otherwise the
  //error message is  empty
  Padding email() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      child: Column(
        children: [
          Text(emailError), //Displays the error message
          TextField(
            decoration: widget.emailDecoration,
            //Displays keyboard optimized for email input
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              //Check if email address has valid format
              setState(() {
                //If there is input, check if it matches the email address format
                if (email.isNotEmpty) {
                  emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email);
                }
                //If the email address is not valid and if there is text in the
                //field, set the error message
                if (!emailValid && email.isNotEmpty) {
                  emailError = "Email adress not valid";
                } else {
                  //If the email address is either valid, or the field is empty,
                  // the error message is empty
                  emailError = "";
                }
              });
            },
          ),
        ],
      ),
    );
  }

  //Function to create the input field for a person's phone number
  Padding phoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: widget.phoneDecoration,
        //Displays keyboard optimized for phone numbers
        keyboardType: TextInputType.phone,
        //Only numbers are accepted as input
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  //Gender picker
  //Function to create a dropdown list for picking genders. The list of genders
  //is either the default list or a list specified by the developer who is using
  //the accountRegistration widget
  Padding gender() {
    //Sets the list of genders to list defined by developer, if provided, or
    //otherwise the default list.
    List<String> genders = widget.genderList;

    //Creates dropdown list
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
          Text(widget.genderLabel), //Title above the dropdown list
          DropdownButton(
            value: selectedGender,
            items: genderList,
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            isExpanded: true, //uses the whole width of the wrapping column
          ),
        ],
      ),
    );
  }

  //Birth date picker
  //Function that creates the dropdown fields for picking a person's birth date
  Padding birthdatePicker() {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    int startYear =
        currentYear - 120; //Assumes a person is at most 120 years old

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.birthDateLabel), //Title above the dropdown menu
          //SizedBox is used to constrain the width
          //If the width is not constrained, the DropdownDatePicker will use the
          //entire width of the screen, making left alignment impossible
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: DropdownDatePicker(
              firstDate: ValidDate(year: startYear, month: 1, day: 1),
              //It is not possible to pick a future date
              lastDate: ValidDate(
                  year: currentYear, month: currentMonth, day: currentDay),
              dateHint: widget.dateHint,
              //Values are descending, to get most recent years on top
              ascending: false,
            ),
          ),
        ],
      ),
    );
  }

  //Function that creates a field width a possible user agreement and a
  //connected checkbox
  Row checkBoxContainer() {
    return Row(
      children: [
        Checkbox(
          value: agreementAccepted,
          onChanged: (bool? value) {
            setState(() {
              agreementAccepted = value!; //Toggles the check box
            });
          },
        ),
        Text(widget.agreementText), //The user agreement description
      ],
    );
  }

  //Check button
  //Function that creates a button that, when clicked, checks if the necessary
  //information is provided and correctly formatted
  TextButton checkerButton() {
    //If the check box for user agreement is not used, agreementAccepted is set
    //to true to not hinder registration
    if (!widget.isAgreementCheckVisible) {
      agreementAccepted = true;
    }

    //If the email field is not used, emailValid is set to true, to not hinder
    //registration
    if (!widget.isEmailVisible) {
      emailValid = true;
    }

    return TextButton(
      onPressed: () {
        setState(() {
          //Gets the validation state from the PasswordForm widget
          passwordAccepted = password.passwordValid;

          //If password fullfils the requirements, email is correctly formatted
          //and the user agreement is accepted, allChecksOK is true
          if (passwordAccepted && emailValid && agreementAccepted) {
            allChecksOK = true;
          } else {
            //If any of the variables are false, allChecksOK is changed back
            allChecksOK = false;
          }
        });
      },
      child: const Text('Check'),
    );
  }

  //Button
  //Function that creates the registration button, that completes the form and
  //performes the provided onButtonClick function
  TextButton registerAccountButton() {
    return TextButton(
      //If all checks are passed, the onButtonClick function is called when the
      //button is pressed, otherwise the function is set to null meaning the
      //button is disabled
      onPressed: allChecksOK
          ? widget.onButtonClick
          : null, //enabled button only if it should be enabled
      child: Text(widget.buttonText),
    );
  }

  //Function that creates the entire registration form
  Widget buildRegistrationForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //Make it possible to scroll
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //Checks are performed so that only the fields set to visible in the
          //constructor are created
          children: [
            //Name field
            widget.isNameVisible ? name() : Container(),
            //Gender field
            widget.isGenderVisible ? gender() : Container(),
            //BirthDateField
            widget.isBirthDateVisible ? birthdatePicker() : Container(),
            //Email field
            widget.isEmailVisible ? email() : Container(),
            //Phone number field
            widget.isPhoneNumberVisible ? phoneNumber() : Container(),
            //Username field, always visible
            username(),
            //Password field, always visible
            password,
            //Agreement checkbox
            widget.isAgreementCheckVisible ? checkBoxContainer() : Container(),
            //Buttons for checking and registering, always visible
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

  //Build function for class AccountRegistration
  //Builds the form
  @override
  Widget build(BuildContext context) {
    return buildRegistrationForm();
  }
}
