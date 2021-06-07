import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/widget/button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    //curved animation
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    controller.forward();
    //add status listener is add for listen the weather animation is completed or not
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.dismissed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    //twine animation
    animation = ColorTween(begin: Colors.pinkAccent, end: Colors.black)
        .animate(controller);

    //set state add for the rebuild the context without it animation is not work
    controller.addListener(() {
      setState(() {});
    });
  }

  // after the closing the app controller is still run which consume memory
  //this is why it should be traced off once it need is fulfill
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonOfChat(
              textValue: 'Login',
              idName: LoginScreen.id,
              colorOfButton: Colors.lightBlue,
            ),
            ButtonOfChat(
              textValue: 'Registration',
              idName: RegistrationScreen.id,
              colorOfButton: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
