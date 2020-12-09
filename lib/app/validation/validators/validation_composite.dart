import 'package:i9vate_sales_force/app/presentation/protocols/protocols.dart';
import 'package:i9vate_sales_force/app/validation/validators/protocols/protocol.dart';
import 'package:meta/meta.dart';

class ValidationComposite implements Validation {
  ValidationComposite(this.validations);

  final List<FieldValidation> validations;

  @override
  String validate({@required String field, @required String value}) {
    String error;
    for (final validation
        in validations.where((element) => element.field == field)) {
      error = validation.validate(value);
      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }
}
