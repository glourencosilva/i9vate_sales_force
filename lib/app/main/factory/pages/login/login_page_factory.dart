import 'package:flutter/widgets.dart';
import 'package:i9vate_sales_force/app/main/factory/factory.dart';
import 'package:i9vate_sales_force/app/ui/screens/screens.dart';

// Widget makeLoginPage() {
//   return LoginScreen(presenter: makeStreamLoginPresenter());
// }

Widget makeLoginPage() {
  return LoginScreen(presenter: makeGetxLoginPresenter());
}
