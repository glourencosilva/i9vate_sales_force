import 'package:flutter/material.dart';
import 'package:i9vate_sales_force/app/ui/screens/login/login.dart';
import 'package:provider/provider.dart';

class EmailInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColorLight,
              ),
              //hintText: 'Entre com seu email',
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              // helperText: 'E-Mail de usuário',
              // counterText: '0 Caractere(s)',
            ),
            keyboardType: TextInputType.emailAddress,
            // ignore: todo
            // TODO Usado nos testes. Verificar a implementação da email no BLoc por exemplo.
            onChanged: presenter.validateEmail,
          );
        });
  }
}
