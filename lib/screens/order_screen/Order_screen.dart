import 'package:flutter/material.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/screens/order_screen/Order_detail.dart';
import 'package:parkink_app/services/database.dart';

class OrderScreen extends StatefulWidget {
  String userId;
  OrderScreen({this.userId});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [];
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();


    var stream = db.getOrders(widget.userId);
    stream.listen((List<Order> data) {
        if(mounted) {
          setState(() {
            orders = data;
            print(orders);
          });
        }
    });
  }
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
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrderDetail(order: orders[index], index: index + 1,)));},
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              margin: EdgeInsets.only(bottom: defaultPadding / 5),
              decoration: BoxDecoration(
                color: orders[index].paided == "Оплачено" ? Colors.greenAccent : Colors.amber,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Заявка: " + (index + 1).toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(orders[index].type),
                      Text("Количество Услуг: " + orders[index].services.length.toString()),
                      Text("Статус: " + orders[index].status),
                      Text("Стоимость: " + orders[index].totalPrice.toString() + " руб."),
                      Text(orders[index].paided),
                    ],
                  ),
                  orders[index].paided == "Не оплачено"? IconButton(icon: Icon(Icons.delete), onPressed: () {db.deleteOrder(orders[index].uid);}): SizedBox(width: 1,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
