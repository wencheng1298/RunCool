import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './../../utils/everythingUtils.dart';
import '../authentication/LogIn.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  void LogIn() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInUI()));
  }

  //final AuthService _auth = AuthService();
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  String password;

  @override
  Widget build(BuildContext context) {
    var user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        //leading: Container(),
      ),
      body: BackgroundImage(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              InputTextField1(text: 'Current password'),
              SizedBox(height: 20),
              InputTextFormFill(
                obscure: true,
                text: 'New password',
                onChange: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 5),
              InputTextFormFill(
                obscure: true,
                text: 'Reconfirm new password',
                onChange: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ButtonType1(
                  text: 'Update password',
                  onPress: () async {
                    await user.updatePassword(password);
                    Phoenix.rebirth(context);
                    // LogIn();
                  }),

              SizedBox(height: 20),
              ButtonType1(
                text: 'Log Out',
                colour: Colors.red,
                onPress: () async {
                  await _auth.signOut();
                  Phoenix.rebirth(context);
                  // return LogIn();
                },
              )
              //ButtonType1(onPress: () => goNextPage(), text: 'log out')
            ],
          ),
        ),
      ),
    );
  }
}
