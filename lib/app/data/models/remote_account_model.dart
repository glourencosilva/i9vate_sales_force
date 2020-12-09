import 'package:i9vate_sales_force/app/domain/core/error/errors.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;

  // AccountEntity(this.token);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    } else {}
    return RemoteAccountModel._(json['accessToken']);
  }

  const RemoteAccountModel._(this.accessToken);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
