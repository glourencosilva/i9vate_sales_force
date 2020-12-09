import 'package:i9vate_sales_force/app/data/core/http/http.dart';
import 'package:i9vate_sales_force/app/data/models/models.dart';
import 'package:i9vate_sales_force/app/domain/core/error/errors.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';
import 'package:i9vate_sales_force/app/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final corpo = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: corpo,
      );
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unespected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  // RemoteAuthenticationParams({
  //   @required this.email,
  //   @required this.password,
  // });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) {
    return RemoteAuthenticationParams._(params.email, params.secret);
  }

  const RemoteAuthenticationParams._(this.email, this.password);

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
