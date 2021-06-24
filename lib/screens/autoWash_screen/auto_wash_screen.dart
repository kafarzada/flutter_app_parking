import 'package:flutter/material.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/screens/autoWash_screen/chose_autowash_service_screen.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

class AutoWash_Screen extends StatefulWidget {
  @override
  _AutoWash_ScreenState createState() => _AutoWash_ScreenState();
}

class _AutoWash_ScreenState extends State<AutoWash_Screen> {
  UserModel user;

  List<Setting> settings = [];

  @override
  void initState() {
    var stream =  DatabaseService().getMaxServiceCount();

    stream.listen((List<Setting> data) {
      setState(() {
        settings = data;
      });
    });

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: (settings.isNotEmpty) ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                //width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(),
                    child:(settings.isNotEmpty || settings[0].authoWashIsWord) ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title("Очередь на Автомойке"),
                        Text(settings[0].isCombo ? "Выберите больше 3 услуги для автивации комбо!": " "),
                        Text(
                          "4",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 80),
                        ),
                        Text("3:40 мин", style: TextStyle(fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              ChoseAutoWashService(
                                                id: user.id,
                                              )));
                                },
                                elevation: 0,
                                icon: Icon(Icons.arrow_forward_ios_outlined),
                                label: Text("Перейти")),
                          ],
                        ),

                      ],
                    ): Center(child: Text("Автомойка временно не работает")),
                  ),
                ),
              )
            ],
          ) : null,
        ));
  }
}
