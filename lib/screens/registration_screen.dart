import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  
  static String id="regis_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool spin=false;

  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context)=>
         ModalProgressHUD(
          inAsyncCall: spin,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                      email=value;

                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "E-Mail(xyz@abc.com)",
                    ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                )
                ,
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      password=value;
                    },
                    decoration: kTextFieldDecoration.copyWith(

                      hintText: "Password(min. 8 Characters)"
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(

                      onPressed: () async {

                        setState(() {
                          spin=true;
                        });
                        //Implement registration functionality.
//                    print(email);
//                    print(password);
                      try {
                        final newuser = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                        if(newuser!=null)
                          {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                      }
                      catch(e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.blueAccent,
                          content: Text('Enter E-Mail and Password correctly/Internet Not Working/User already exists'),
                          action: SnackBarAction(
                            label: 'Try Again',
                            textColor: Colors.black,
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        print(e);
                      }
                        setState(() {
                          spin=false;
                        });

                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
