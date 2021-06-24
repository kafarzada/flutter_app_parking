import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants.dart';

Widget textFiled(BuildContext context, String name, TextInputType type, String label, TextEditingController controller, bool obscure) {
  return  Padding(
    padding: const EdgeInsets.only(top: defaultPadding),
    child: FormBuilderTextField(
      name: name,
      controller: controller,
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
          labelText:  label
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
        FormBuilderValidators.max(context, 100),
      ]),
    ),
  );
}