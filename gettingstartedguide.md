# Getting Started Guide With Flutter

> This getting started guide is aimed at people who have experience programming but who have not worked  with flutter. 

## What is Flutter?
> Flutter is a UI-based development kit devolped by Google which is great for app development. Flutter is using the programming language Dart. To first get Flutter
running, all the necessary steps to install the SDK can be found in the documentation [here](https://docs.flutter.dev/get-started/install).

## Create the App

With the SDK installed the program can be run in several IDE (integrated development environments) such as Android Studio, IntelliJ, VS Code, or Emacs. Other 
editors will be okay but won't necessary have the same built in support at these IDEs. How the app is set up can be found [here](https://docs.flutter.dev/get-started/test-drive?tab=androidstudio).

## Simple Layout of components / widgets

The following code snippet displays how an app displaying "Hello World" is written. The layout of Flutter mainly relies on compenents called "Widgets". 
Widgets can have different forms depending on their interactions. The main here calls on a class with extended widget called StatelessWidget. 
Stateless is "state" which informs the class that if won't change state. While the class can't change state functions called inside the class do so. 

"Widget Build" intializes the application and returns a Materialapp which contains all the inbuilt components inside the Flutter library. The materialapp creates
instance of Widget app which contains several inbuilt commands. 
 
Here "Title" will display the bar address. Scaffold home will create a bar around the project. While the body is where the primary functions of the scaffold will be displayed. Here a child is initialized which creates a widget or "component" for the class. This child can be given extra functionality dependending on what's written inside of it. Here the text "Hello world" will be displayed. 

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

## Basic interaction with listener / callbacks functions

Flutter is mainly constructed with familiarity to other Object Oriented Programming (OOP) languages. The functionality of the app looks similar to how Java and 
Javascript funtions. With the basic layout of the application implemented, basic functions can easily be called by calling them inside widgets or inside the main. 
The functionality of the function "customiseGreeting" is creating a function which takes in a a greeting, which specifies a name inside of it. This will then can able to print if called by "print" and suitable variable which is converted into a string. 

```
Function customiseGreeting(String greeting) {
  return (String name) => '$greeting, $name,';
}
void main() {
  var goodMorning = customizeGreeting('Good morning');
  var goodEvening = customizeGreeting('Good evening');
  print(goodMorning('Monica'));
  print(goodEvening('Monica'));
}
```



## Navigation between different screens

The following code shows two widgets which navigates between two different screens inside the application. All the functionality is done inside the body of the stateless widgets. The widget "FirstRoute" will first call the inbuilt function "MaterialPageRoute" to build SecondRoute.

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

