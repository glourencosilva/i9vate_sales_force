import 'package:i9vate_sales_force/app/main/factory/factory.dart';
import 'package:i9vate_sales_force/app/presentation/manager/manager.dart';
import 'package:i9vate_sales_force/app/ui/screens/screens.dart';

// LoginPresenter makeStreamLoginPresenter() {
//   return StreamLoginPresenter(
//     validation: makeLoginValidation(),
//     authentication: makeRemoteAuthentication(),
//   );
// }

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
    saveCurrentAccount: makeLocaSaveCurrentAccount(),
  );
}
