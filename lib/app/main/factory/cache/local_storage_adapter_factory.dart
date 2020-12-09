import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:i9vate_sales_force/app/infrastructure/infra.dart';

LocalStorageAdapter makeLocaLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  return LocalStorageAdapter(secureStorage: secureStorage);
}
