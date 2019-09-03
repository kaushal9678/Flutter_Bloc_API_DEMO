import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import './screens/Surveyform_screen.dart';
import './screens/Settings_screen.dart';
import './screens/Thankyou_screen.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Railway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
      ),
      home: Scaffold(
        body: WelcomeScreen(),
      ),
      routes: {
        '/welcome':(ctx)=>WelcomeScreen(),
        '/survey-form': (ctx) => SurveyForm(),
        '/thankyou': (ctx) => ThankyouScreen(),
        '/settings': (ctx) => Settings(),
      } ,
    );
  }
}
