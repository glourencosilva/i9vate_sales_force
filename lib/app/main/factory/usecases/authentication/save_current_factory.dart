import 'package:i9vate_sales_force/app/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:i9vate_sales_force/app/domain/usecases/save_current_account.dart';
import 'package:i9vate_sales_force/app/main/factory/cache/cache.dart';

SaveCurrentAccount makeLocaSaveCurrentAccount() {
  final saveSecureCacheStore = makeLocaLocalStorageAdapter();
  return LocalSaveCurrentAccount(saveSecureCacheStore: saveSecureCacheStore);
}
