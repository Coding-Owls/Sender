import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Screen1.dart';
import 'package:flutter_app/wave.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:uuid/uuid.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
         theme: ThemeData(
          primarySwatch: Colors.brown
         ),
         debugShowCheckedModeBanner: false,
         home: SplashScreenView(
             home: MyCustomForm(),
           text: "Beaconer",
           textStyle: TextStyle(fontSize: 25),
           textType: TextType.TyperAnimatedText,
           imageSrc: "assets/logo.png",
           imageSize: 400,
           duration: 4000,
         ),
       );


  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/logo.png", height: 250, width: 250,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                    labelText: 'Enter a message',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.message),
                    focusColor: Colors.orange
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:70.0),
                child: FlatButton(onPressed: () => onPressed1(context), child: Text("Send", style: TextStyle(color: Colors.white), ), color: Colors.orangeAccent,),
              ),
              WaveDemoHomePage(title: 'Wave Demo')
            ],
          ),
        ),
    );
  }
  void onPressed1(BuildContext context){
    String message = myController.text;
    if(message!="") {
      String id = Uuid().v1();
      myController.clear();
      SaveToFirebase(message, id);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Screen1(message: message, id: id)));
    }
  }
// ignore: non_constant_identifier_names
void SaveToFirebase(String message, String id){
    if(message!="") {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("Messages").doc(id).set({
        "val": message
      });
    }
}
}





