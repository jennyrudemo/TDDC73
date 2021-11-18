import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lab 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  //Method to create the buttons
  TextButton _myButton() {
    TextStyle textStyle = TextStyle(fontSize: 18.0);

    //Define style for button
    ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade300),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(textStyle),
    );

    //Create button
    return TextButton(
      onPressed: null,
      child: Text("BUTTON"),
      style: style,
    );
  }

  //Method to create row element with two buttons
  Row _buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _myButton(),
        _myButton(),
      ],
    );
  }

  //Method to create grid of buttons
  //A column consisting of two row elements
  Column _buttonGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buttonRow(),
        _buttonRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Image icon = new Image.asset('assets/Education-Wheel-Woofer.png');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //Padding for the whole body
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
        child: Center(
          child: Column(
            //The widgets in the column are centered vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Using Expanded widgets to wrap the other elements, to be able to use the flex property
              //child 1: image
              Expanded(
                child: icon,
                flex: 1,
              ),
              //child 2: button grid
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buttonGrid(),
                ),
              ),
              //child 3: row of email input
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email"),
                    //TODO: Check why this field is lower than the text to the left of it
                    //TextFormField wrapped with Expanded, otherwise it doesn't work
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
