import 'dart:async';
import 'package:get_it/get_it.dart';

import 'teste_validator.dart';

class TesteBloc extends Object with TesteValidator {
  final _emailStreamController = StreamController<String>();
  final _passwordStreamController = StreamController<String>();

  //Adiciona dados ao Stream
  Stream<String> get emailTeste =>
      _emailStreamController.stream.transform(validateEmail);
  Stream<String> get passwordTeste =>
      _passwordStreamController.stream.transform(validatePassword);

  //Altera dados do Stream
  Function(String) get changeEmail => _emailStreamController.sink.add;
  Function(String) get changePassword => _passwordStreamController.sink.add;

  void dispouse() {
    _emailStreamController.isClosed == false
        ? _emailStreamController.close()
        : _emailStreamController.onCancel;

    _passwordStreamController.isClosed == false
        ? _passwordStreamController.close()
        : _passwordStreamController.onCancel;
  }
}

final getIt = GetIt.instance;
final testeBloc = getIt.registerSingleton(TesteBloc());
