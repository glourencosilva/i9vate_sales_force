import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i9vate_sales_force/app/main/factory/factory.dart';
import 'package:i9vate_sales_force/app/ui/widgets/widgets.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'i9',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(
            name: '/surveys',
            page: () => Scaffold(
                  body: Text('Enquete'),
                )),
      ],
    );
  }
}
