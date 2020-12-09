import 'package:i9vate_sales_force/app/data/usecases/authentication/remoute_authentication.dart';
import 'package:i9vate_sales_force/app/domain/usecases/authentication.dart';
import 'package:i9vate_sales_force/app/main/factory/http/http.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
    url: makeApiUrl('login'),
    httpClient: makeHttpAdapter(),
  );
}
