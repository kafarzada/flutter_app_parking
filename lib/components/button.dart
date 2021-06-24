import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkink_app/constants.dart';

Widget button(BuildContext context, String text, void func()) {
  return  RaisedButton(

    onPressed: () {func();},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child:Container(width: MediaQuery.of(context).size.width * 0.7, child: Text(text, textAlign: TextAlign.center,),),
    textColor: Colors.white,
    splashColor: Colors.white24,
    padding: EdgeInsets.symmetric(vertical: 16),
    color: buttonColor,
  );
}

