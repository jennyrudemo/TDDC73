import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:email_validator/email_validator.dart';

class AccountRegistration extends StatefulWidget {
  AccountRegistration({
    Key? key,
    nameDecoration,
    usernameDecoration,
    emailDecoration,
    phoneDecoration,
    genderList,
    passwordDecoration,
  }) : super(key: key);

  //Default values
  final InputDecoration nameDecoration = const InputDecoration(
    labelText: 'Full name',
  );

  //TODO: Fixa så att label alltid ligger på toppen
  final InputDecoration usernameDecoration = const InputDecoration(
    labelText: 'Username',
  );

  final InputDecoration emailDecoration = const InputDecoration(
    labelText: 'Email',
  );

  final InputDecoration phoneDecoration = const InputDecoration(
    labelText: 'Phone number',
  );

  final List<String> genderList = const [
    'Female',
    'Male',
    'Other',
    'Prefer not to say',
  ];

  final InputDecoration passwordDecoration = const InputDecoration(
    labelText: 'Password',
  );

  @override
  State<AccountRegistration> createState() => _AccountRegistration();
}

class _AccountRegistration extends State<AccountRegistration> {
  //String selectedGender = 'Female';
  String selectedGender = "Female";
  int selectedYear = DateTime.now().year;
  //String selectedMonth = 'Jan';
  //String selectedDay = '1';

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
      validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
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
  DropdownButton<String> gender() {
    List<String> genders = widget.genderList;

    List<DropdownMenuItem<String>> genderList =
        genders.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButton(
      value: selectedGender,
      items: genderList,
      onChanged: (String? newValue) {
        setState(() {
          selectedGender = newValue!;
        });
      },
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

  /*DateTime selectedDate = DateTime.now();
  CalendarDatePicker birthdate() {
    return CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now(),
        onDateChanged: (pickedDate) =>
            {selectedDate = pickedDate}); //Behöver detta vara en set state?
  }*/

  //TODO: consider putting this in its own file
  Row birthdatePicker() {
    int startYear = 1900;
    int endYear = DateTime.now().year;
    List<int> years = [
      for (int year = endYear; year >= startYear; year--) year
    ];
    //print(years);
    //List<String> years = ['1900', '1901']; //TODO: automatiskt generera
    //List<String> months = ['Jan', 'Feb']; //TODO: lägga till alla månader
    //List<String> days = ['1', '2']; //TODO: lägga till alla dagar

    List<DropdownMenuItem<int>> yearList =
        years.map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();

    /*List<DropdownMenuItem<String>> monthList =
        months.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    List<DropdownMenuItem<String>> dayList =
        days.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();*/

    Row birthdate = Row(
      children: [
        DropdownButton(
          value: selectedYear,
          items: yearList,
          onChanged: (int? newValue) {
            setState(() {
              selectedYear = newValue!;
            });
          },
        ),
        /*DropdownButton(
          value: selectedMonth,
          items: monthList,
          onChanged: (String? newValue) {
            setState(() {
              selectedMonth = newValue!;
            });
          },
        ),
        DropdownButton(
          value: selectedDay,
          items: dayList,
          onChanged: (String? newValue) {
            setState(() {
              selectedDay = newValue!;
            });
          },
        ),*/
      ],
    );

    return birthdate;
  }

  Widget accountRegistration() {
    //TODO: replace with actual content
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          name(),
          username(),
          email(),
          phoneNumber(),
          gender(),
          password(),
          birthdatePicker(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return accountRegistration();
  }
}
