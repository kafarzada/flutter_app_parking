import 'package:flutter/material.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/textfield.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _patronymicController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Редактировать Данные",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            textFiled(context, "firstname", TextInputType.text, "Фамилия",
                _firstnameController, false),
            textFiled(context, "lastname", TextInputType.text, "Имя",
                _lastnameController, false),
            textFiled(context, "patronymic", TextInputType.text, "Отчество",
                _patronymicController, false),
            textFiled(context, "phone", TextInputType.text, "Номер Телефона",
                _phoneController, false),
            Spacer(
              flex: 1,
            ),
            button(context, "Сохранить", () {
              Client client = Client(
                  firstname: _firstnameController.text,
                  lastname: _lastnameController.text,
                  patronymic: _patronymicController.text,
                  phone: _phoneController.text);
              DatabaseService db = DatabaseService();
              db
                  .updateClientData(user.id, client)
                  .then((value) => Navigator.pop(context));
            })
          ],
        ),
      ),
    );
  }
}
