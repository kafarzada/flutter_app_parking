
import 'package:flutter/material.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/screens/welcome/component/body.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
        body:Body()
    );
  }
}