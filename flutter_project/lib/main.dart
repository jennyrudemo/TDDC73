import 'package:flutter/material.dart';
import 'package:flutter_project/account_registration.dart';
//import 'package:flutter_project/password.dart';

// Declares myApp function
void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String example = "";

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      //body: const PasswordForm(),
      body: AccountRegistration(
        //isAgreementCheckVisible: false, //Possible to decide what fields to use
        //birthDateLabel: "Födelsedatum", //Possible to change labels
        onButtonClick: () {
          print('Nothing happens, this is just a sample application');
        },
      ),
    );
  }
}
