import 'package:faker/faker.dart';
import 'package:i9vate_sales_force/app/domain/core/error/errors.dart';
import 'package:i9vate_sales_force/app/domain/entities/entities.dart';
import 'package:i9vate_sales_force/app/domain/usecases/usecases.dart';
import 'package:i9vate_sales_force/app/presentation/manager/manager.dart';
import 'package:i9vate_sales_force/app/presentation/protocols/protocols.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  SaveCurrentAccountSpy saveCurrentAccount;
  GetxLoginPresenter sut;
  String email;
  String password;
  String token;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
        field: field ?? anyNamed('field'),
        value: anyNamed('value'),
      ));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  PostExpectation mockSaveCurrentAccountCall() =>
      when(saveCurrentAccount.save(any));
  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unespected);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxLoginPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount,
    );
    email = faker.internet.email();
    password = faker.internet.password();
    token = faker.guid.guid();
    mockValidation();
    mockAuthentication();
  });

  test('shoult call Validation with correct email.', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('shoult emit email error if validation fails.', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    expectLater(sut.emailErrorStream, emitsInOrder(['error']));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    expectLater(sut.emailErrorStream, emitsInOrder(['error']));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('shoult emit null if validation succeed.', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('shoult call Validation with correct password.', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('shoult emit password error if validation fails.', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('shoult emit password error if validation fails.', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    // ignore: unawaited_futures
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('shoult call Authentication with correct values.', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();

    verify(authentication.auth(AuthenticationParams(
      email: email,
      secret: password,
    ))).called(1);
  });

  test('shoult call SaveCurrentAccount with correct value.', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();

    verify(saveCurrentAccount.save(AccountEntity(token))).called(1);
  });

  test('should emit UnexpectedError if SaveCurrentAccount fails.', () async {
    mockSaveCurrentAccountError();
    sut.validateEmail(email);
    sut.validatePassword(password);

    // ignore: unawaited_futures
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(
        error, 'Erro inesperado. Algo deu errado. Tente novamente em breve.')));

    await sut.auth();
  });

  test('shoult emit correct events on Authentication success.', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    // ignore: unawaited_futures
    expectLater(sut.isLoadingStream, emits(true));

    await sut.auth();
  });

  test('shoult change page on success.', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.auth();
  });

  test('should emit correct on Invalide Crendentiial Error.', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    // ignore: unawaited_futures
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(
        expectAsync1((error) => expect(error, 'Credenciais inválidas.')));

    await sut.auth();
  });

  test('should emit correct on UnexpectedError.', () async {
    mockAuthenticationError(DomainError.unespected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    // ignore: unawaited_futures
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(
        error, 'Erro inesperado. Algo deu errado. Tente novamente em breve.')));

    await sut.auth();
  });

  // test('should not emit after dispose.', () async {
  //   await expectLater(sut.emailErrorStream, neverEmits(null));
  //   sut.dispose();
  //   sut.validateEmail(email);

  //   // expectLater(sut.isLoadingStream, emits(false));
  //   // sut.mainErrorStream.listen(expectAsync1((error) => expect(
  //   //     error, 'Erro inesperado. Algo deu errado. Tente novamente em breve.')));

  //   // await sut.auth();
  // });
}
