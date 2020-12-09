import 'package:equatable/equatable.dart';

import '../../validation/validators/protocols/protocol.dart';

class EmailValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String value) {
    final isValid = value?.isNotEmpty == false || _isEmail(value);
    return isValid ? null : 'E-Mail inválido.';
  }

  static bool _isEmail(String email) {
    var _p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final _regExp = RegExp(_p);
    return _regExp.hasMatch(email);
  }

  @override
  List<Object> get props => [field];
}
