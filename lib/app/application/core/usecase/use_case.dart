import 'package:dartz/dartz.dart';

import '../error/falhas.dart';

// Os parâmetros devem ser colocados em um objeto recipiente para que possam ser
// incluído nesta definição de método de classe base abstrata.
abstract class UseCase<Type, Params> {
  Future<Either<Falhas, Type>> call(Params params);
}

// class Params extends Equatable {
//   final int number;

//   Params({@required this.number}) : super();

//   @override
//   List<Object> get props => [number];
// }
