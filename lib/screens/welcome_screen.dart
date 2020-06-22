import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounder_button.dart';
import 'package:flash_chat/constants.dart';
class WelcomeScreen extends StatefulWidget {
  static String id="welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation animation,animsize;
  @override
  void initState() {

    animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds:1),

    );

    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(animationController);
    animsize=CurvedAnimation(parent: animationController,curve: Curves.decelerate);
    // TODO: implement initState
    super.initState();
    
    animationController.forward();

// If we want to make it infinite then see below
//    animation.addStatusListener((status){
//
//      if(status==AnimationStatus.completed)
//        animationController.reverse(from: 1.0);
//      else
//        animationController.forward();
//    });
    animationController.addListener((){
      print(animationController.value);
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(

                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animsize.value*100,
                  ),
                ),
                Expanded(
                  child: TypewriterAnimatedTextKit(

                    speed: Duration(milliseconds: 250),
                     repeatForever: true,
                    text:['Flash Chat'],


                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(txt: "Log In",color: Colors.lightBlueAccent,onPressed:(){
              Navigator.pushNamed(context,LoginScreen.id);
            },),
            RoundedButton(
              txt: "Register",
              color: Colors.blueAccent,
              onPressed: (){
                Navigator.pushNamed(context,RegistrationScreen.id);
              },
            ),
           SizedBox(
             height: 150.0,
           ),

            Center(
              child: Container(
                
                child: Text(
                  "Made with ❤️ by Pranav Singhal"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

