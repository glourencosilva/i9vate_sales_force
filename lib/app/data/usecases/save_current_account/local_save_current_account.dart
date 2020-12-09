import 'package:equatable/equatable.dart';
import 'package:i9vate_sales_force/app/data/core/core.dart';
import 'package:i9vate_sales_force/app/domain/core/core.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';
import 'package:i9vate_sales_force/app/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

class LocalSaveCurrentAccount extends Equatable implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStore;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStore});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStore.saveSecure(key: 'token', value: account.token);
    } catch (_) {
      throw DomainError.unespected;
    }
  }

  @override
  List<Object> get props => [saveSecureCacheStore];
}
