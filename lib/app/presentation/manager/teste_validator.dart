import 'dart:core';
import 'dart:async';

class TesteValidator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (_isEmail(email)) {
      sink.add(email);
    } else {
      sink.addError('Entre com um e-mail válido');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Insira uma senha com pelomenos 3 catacteres válidos.');
    }
  });

  static bool _isEmail(String email) {
    var p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(p);
    return regExp.hasMatch(email);
  }
}
