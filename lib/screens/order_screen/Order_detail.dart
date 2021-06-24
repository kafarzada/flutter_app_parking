import 'package:flutter/material.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/screens/order_screen/Payment_screen.dart';

import '../../constants.dart';

class OrderDetail extends StatefulWidget {
  Order order;
  int index;

  OrderDetail({this.order, this.index});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text("Заявка Номер " + widget.index.toString()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: title("Подробнее"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Услуги:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.services.length,
                itemBuilder: (_, i) => Text(widget.order.services[i].name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Транспорты:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.cars.length,
                itemBuilder: (_, i) => Text(widget.order.cars[i].marka),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Дата и Время Создание Заявки:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(widget.order.order_date.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Цена" + widget.order.totalPrice.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Spacer(
              flex: 2,
            ),
            Center(
                child: widget.order.paided == "Не оплачено" ? button(context, "Перейти к оплате", () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => PaymentScreen(order: widget.order)));
                }): null)
          ],
        ),
      ),
    );
  }
}
