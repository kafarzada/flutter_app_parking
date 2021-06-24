import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/textfield.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/screens/order_screen/Order_detail.dart';
import 'package:parkink_app/services/database.dart';

class PaymentScreen extends StatefulWidget {
  Order order;

  PaymentScreen({this.order});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text("Заявки"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Container(
            child: Column(
              children: [
                title("Оплата"),
                Icon(
                  Icons.payment,
                  size: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: FormBuilderTextField(
                    name: "price",
                    obscureText: false,
                    decoration: InputDecoration(labelText: "Плата"),
                    initialValue: widget.order.totalPrice.toString() + " .руб",
                    enabled: false,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                widget.order.paided == "Не оплачено" ?button(context, "Оплатить", () {
                  DatabaseService db = DatabaseService();
                  db
                      .payment(widget.order.uid, widget.order.paymentToMap())
                      .then((value) => Navigator.pop(context));
                }) : SizedBox(width: 1,)
              ],
            ),
          ),
        ));
  }
}
