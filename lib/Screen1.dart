import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Screen1 extends StatelessWidget{
  String message;
Screen1({
this.message
});
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Ji $message"),
            ],
          )),
    );
  }

}