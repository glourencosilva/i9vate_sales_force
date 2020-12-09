import 'package:flutter/material.dart';
import 'package:i9vate_sales_force/app/ui/screens/login/login.dart';
import 'package:provider/provider.dart';

class LoginButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: snapshot.data == true ? presenter.auth : null,
            child: Text('Entrar'.toUpperCase()),
          );
        });
  }
}
