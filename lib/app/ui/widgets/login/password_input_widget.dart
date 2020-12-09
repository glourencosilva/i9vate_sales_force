import 'package:flutter/material.dart';
import 'package:i9vate_sales_force/app/ui/screens/login/login.dart';
import 'package:provider/provider.dart';

class PasswordInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColorLight,
              ),
              //hintText: 'Entre com sue senha',
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              // helperText: 'Senha para login',
              // counterText: '0 Caractere(s)',
            ),
            keyboardType: TextInputType.visiblePassword,
            // ignore: todo
            // TODO Usado nos testes. Verificar a implementação da senha no BLoc por exemplo.
            onChanged: presenter.validatePassword,
            obscureText: true,
          );
        });
  }
}
