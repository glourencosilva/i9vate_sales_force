import 'package:equatable/equatable.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';
import 'package:meta/meta.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  AuthenticationParams({
    @required this.email,
    @required this.secret,
  });

  @override
  List<Object> get props => [email, secret];
}
