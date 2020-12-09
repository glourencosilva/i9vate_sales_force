import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:i9vate_sales_force/app/infrastructure/infra.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// class LocalStorageAdapter extends Equatable implements SaveSecureCacheStorage {
//   final FlutterSecureStorage secureStorage;

//   LocalStorageAdapter({this.secureStorage});

//   @override
//   Future<void> saveSecure(
//       {@required String key, @required String value}) async {
//     await secureStorage.write(key: key, value: value);
//   }

//   @override
//   List<Object> get props => [secureStorage];
// }

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FlutterSecureStorageSpy secureStorage;
  LocalStorageAdapter sut;
  String key;
  String value;
  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter();
    key = faker.lorem.word();
    value = faker.guid.guid();
  });
  test('Should call save secure with correct values.', () async {
    sut = LocalStorageAdapter(secureStorage: secureStorage);

    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should cthrow if save secure throws.', () async {
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
