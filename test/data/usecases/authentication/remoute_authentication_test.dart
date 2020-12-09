import 'package:faker/faker.dart';
import 'package:i9vate_sales_force/app/data/core/http/http.dart';
import 'package:i9vate_sales_force/app/data/usecases/usecases.dart';
import 'package:i9vate_sales_force/app/domain/core/error/errors.dart';
import 'package:i9vate_sales_force/app/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// class RemoteAuthentication {
//   final HttpClient httpClient;
//   final String url;

//   RemoteAuthentication({
//     @required this.url,
//     @required this.httpClient,
//   });

//   Future<void> auth(AuthenticationParams params) async {
//     await httpClient.request(url: url, method: 'post', body: params.toJson());
//   }
// }

// abstract class HttpClient {
//   Future<void> request(
//       {@required String url, @required String method, Map body});
// }

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  AuthenticationParams params;

  Map<String, dynamic> mockValidData() =>
      {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  PostExpectation _mockRequest() => when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body')));

  void mockHttpData(Map<String, dynamic> data) {
    _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    _mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(
      httpClient: httpClient,
      url: url,
    );
    params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );

    mockHttpData(mockValidData());
  });
  test('should call HttpClient with correct values', () async {
    final accessToken = faker.guid.guid();

    when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body'),
    )).thenAnswer(
        (_) async => {'accessToken': accessToken, 'name': faker.person.name()});

    await sut.auth(params);
    verify(httpClient.request(url: url, method: 'post', body: {
      'email': params.email,
      'password': params.secret,
    }));
  });

  test('should throw UnexpectedError is HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unespected));
  });

  test('should throw UnexpectedError is HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unespected));
  });

  test('should throw UnexpectedError is HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unespected));
  });

  test('should throw UInvalidCredentialsError is HttpClient returns 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('should return an Account if is HttpClient returns 200', () async {
    final vadidData = mockValidData();
    mockHttpData(vadidData);

    final account = await sut.auth(params);

    expect(account.token, vadidData['accessToken']);
  });

  test(
      'should throw UnexpectedError if HttpClient returns 200 with invalide data',
      () async {
    mockHttpData({'invalid_key': 'invalide_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unespected));
  });
}
