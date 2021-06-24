import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/screens/connected_screen/connected_screen.dart';
import 'package:parkink_app/screens/home/home.dart';
import 'package:parkink_app/screens/loadScreen/Loading.dart';
import 'package:parkink_app/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);

    final bool  isLoggedIn = user != null;

    return isLoggedIn ? HomeScreen() : Welcome();

  }
}
