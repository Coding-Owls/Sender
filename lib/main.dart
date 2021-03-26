import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
         home: MyCustomForm(),
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
    return MaterialApp(
      home: Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: "Enter a Message!",
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
                TextButton(onPressed: () => onPressed1(context), child: Text("Send"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void onPressed1(BuildContext context){
    print(myController.text);
    String message = myController.text;
    myController.clear();
    SaveToFirebase(message);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Screen1(message : message)));
  }
// ignore: non_constant_identifier_names
void SaveToFirebase(String message){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Messages").add({
      "val": message
    });
}
}





