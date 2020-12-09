import 'package:http/http.dart';
import 'package:i9vate_sales_force/app/data/core/core.dart';
import 'package:i9vate_sales_force/app/infrastructure/infra.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client: client);
}
