import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i9vate_sales_force/app/ui/screens/login/login.dart';
import 'package:i9vate_sales_force/app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginScreen({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _hideKeyBoard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoadingDialogWidget(context);
            } else {
              rideLoadingWidget(context);
            }
          });

          presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });

          return GestureDetector(
            onTap: _hideKeyBoard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeaderWidget(),
                  HeadLineWidget(text: 'Login'),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Provider<LoginPresenter>(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: EmailInputWidget(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: PasswordInputWidget(),
                            ),
                            LoginButtonWidget(),
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.person),
                              label: Text('Criar conta'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
