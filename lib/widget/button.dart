import 'package:flutter/material.dart';

class ButtonOfChat extends StatelessWidget {
  ButtonOfChat({this.textValue, this.colorOfButton, this.idName});
  final String idName;
  final Color colorOfButton;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colorOfButton,
        borderRadius: BorderRadius.circular(30.0),
        elevation:
            5.0, //this is used to give shadow to the button which we are add
        child: MaterialButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) {
            //   return RegistrationScreen();
            // }));
            Navigator.pushNamed(context, idName);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            textValue,
          ),
        ),
      ),
    );
  }
}
