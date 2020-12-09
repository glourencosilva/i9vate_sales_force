import 'package:faker/faker.dart';
import 'package:i9vate_sales_force/app/data/core/core.dart';
import 'package:i9vate_sales_force/app/data/usecases/usecases.dart';
import 'package:i9vate_sales_force/app/domain/core/error/domain_error.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// class LocalSaveCurrentAccount implements SaveCurrentAccount {
//   final SaveSecureCacheStorage saveSecureCacheStore;

//   LocalSaveCurrentAccount({@required this.saveSecureCacheStore});

//   @override
//   Future<void> save(AccountEntity account) async {
//     try {
//       await saveSecureCacheStore.saveSecure(key: 'token', value: account.token);
//     } catch (_) {
//       throw DomainError.unespected;
//     }
//   }
// }

// abstract class SaveSecureCacheStorage {
//   Future<void> saveSecure({@required String key, @required String value});
// }

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  LocalSaveCurrentAccount sut;
  SaveSecureCacheStorageSpy saveSecureCacheStore;
  AccountEntity account;

  setUp(() {
    saveSecureCacheStore = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStore: saveSecureCacheStore);
    account = AccountEntity(faker.guid.guid());
  });

  void mockError() {
    when(saveSecureCacheStore.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
  }

  test('Should call SaveSecureCacheStorage with corrent values', () async {
    await sut.save(account);
    verify(saveSecureCacheStore.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unespected));
  });
}
