import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
String email;
String password;

class LoginScreen extends StatefulWidget {

  static String id="login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth=FirebaseAuth.instance;

  bool spin=false;
  @override
  void initState() {
    // TODO: implement initState
    spin=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) =>
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
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email=value;
                    print(email);
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "E-Mail(xyz@abc.com)"),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password=value;
                    print(password);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: kTextFieldDecoration.copyWith(hintText: "Password(Min. 8 Characters)"),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async{
                        //Implement login functionality.
                        setState(() {
                          spin=true;
                        });
                        var snackBar;
                        try{
                         final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                         print(user);
                         Navigator.pushNamed(context, ChatScreen.id);
                        }

                        catch(e){
                           snackBar = SnackBar(
                            content: Text("Email Id or Password is Wrong/Internet not Working"),
                            backgroundColor: Colors.lightBlue,
                            action: SnackBarAction(
                              label: 'Try Again',
                              textColor: Colors.black,
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          print(e);
                          print("nhi chalaa");
                        }
                        setState(() {

                          spin=false;

                        });

                        print(context.toString());
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
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
