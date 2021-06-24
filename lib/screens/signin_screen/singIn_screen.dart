import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/textfield.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/services/auth.dart';

class SignIn_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    void singin()async {
      final _email = _emailController.text.trim();
      final _password = _passwordController.text.trim();

      if(_email.isEmpty || _password.isEmpty) return ;

      UserModel user = await AuthService().signInWithEmailAndPassword(_email, _password) ;

      if(user == null) {
        Fluttertoast.showToast(
            msg: "Проверьте Почту или Пароль",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
        Navigator.pop(context);
      }
    }



    Widget _form() {
      return FormBuilder(
          child: Padding(
            padding: EdgeInsets.only(top: 115, left: defaultPadding, right: defaultPadding),
            child: Column(

               children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      title("Войти"),
                    ],
                  ),
                 textFiled(context, "email", TextInputType.emailAddress, "E-mail", _emailController, false),
                 textFiled(context, "password", TextInputType.text, "Пароль", _passwordController, true),
                 SizedBox(height: 40,),
                 button(context, "Войти", ()  { singin(); } ),
                 FlatButton(
                     onPressed: () {},
                   child: Text("Забыли пароль?", style: TextStyle(color: Colors.redAccent),),
                 )
               ],
            ),
          ),
      );


    }




    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.39, MediaQuery.of(context).size.height * 0.35),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth
                  )
                ),
              ),
            ),
            _form()
          ],
        ),
      ),
    );


  }
}
