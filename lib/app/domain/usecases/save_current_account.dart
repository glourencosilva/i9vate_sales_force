import 'package:i9vate_sales_force/app/domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity account);
}
