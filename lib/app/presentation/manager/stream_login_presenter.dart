import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:i9vate_sales_force/app/domain/core/error/errors.dart';
import 'package:i9vate_sales_force/app/ui/screens/login/login_presenter.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/authentication.dart';
import '../protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String navigateTo;
  String passwordError;
  String mainError;
  bool isLoading = false;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  var _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  @override
  Stream<String> get emailErrorStream =>
      _controller?.stream?.map((state) => state.emailError)?.distinct();

  @override
  Stream<String> get passwordErrorStream =>
      _controller?.stream?.map((state) => state.passwordError)?.distinct();

  @override
  Stream<String> get mainErrorStream =>
      _controller?.stream?.map((state) => state.mainError)?.distinct();

  @override
  Stream<String> get navigateToStream =>
      _controller?.stream?.map((state) => state.navigateTo)?.distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller?.stream?.map((state) => state.isFormValid)?.distinct();

  @override
  Stream<bool> get isLoadingStream =>
      _controller?.stream?.map((state) => state.isLoading)?.distinct();

  void _update() => _controller?.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(
          AuthenticationParams(email: _state.email, secret: _state.password));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }
    _state.isLoading = false;
    _update();
  }

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
    // ignore: todo
    //TODO Não sei se é válido _state.mainError = null; para corrigir o erro do snackBar
    _state.mainError = null;
  }
}
