import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/textfield.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

class AddCar extends StatelessWidget {

  UserModel user;
  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);


    TextEditingController _markaController = TextEditingController();
    TextEditingController _modelController = TextEditingController();
    TextEditingController _gosNumberController = TextEditingController();

    Widget _form() {
      return FormBuilder(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            textFiled(context, "marka", TextInputType.text, "Марка", _markaController, false),
            textFiled(context, "model", TextInputType.text,"Модель", _modelController, false),
            textFiled(context, "gosNumber", TextInputType.text,"Номер Транспорта", _gosNumberController, false),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding * 2),
              child: button(context, "Добавить", () {
                Car car = Car(marka: _markaController.text,
                              model: _modelController.text,
                              gosNumber: _gosNumberController.text,
                              place: 0,
                              userId: user.id,
                              status: false);
                db.addOrUpdateCar(car).then((value) => Navigator.pop(context));

              }),
            )
          ],
        ),
      );
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title("Новый Транспорт"),
            _form(),
          ],
        ),
      ),
    );
  }
}
