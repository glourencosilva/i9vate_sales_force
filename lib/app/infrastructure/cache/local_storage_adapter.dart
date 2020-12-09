import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:i9vate_sales_force/app/data/core/core.dart';
import 'package:meta/meta.dart';

class LocalStorageAdapter extends Equatable implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({this.secureStorage});

  @override
  Future<void> saveSecure(
      {@required String key, @required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  List<Object> get props => [secureStorage];
}
