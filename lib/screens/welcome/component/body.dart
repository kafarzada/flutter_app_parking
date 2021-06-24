import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/screens/sinUp_screen/singup_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(MediaQuery.of(context).size.width * 0.42, 0),
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/back.png",
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Добро\nпожаловать",
                style: TextStyle(
                    fontSize: titleFontSize, fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(context, "Продолжить", () { return Navigator.push(context, MaterialPageRoute(builder: (ctx) => Signup_Screen())); })
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

