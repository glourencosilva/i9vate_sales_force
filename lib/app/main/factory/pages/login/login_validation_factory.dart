import 'package:i9vate_sales_force/app/main/build/build.dart';
import 'package:i9vate_sales_force/app/presentation/protocols/protocols.dart';
import 'package:i9vate_sales_force/app/validation/validators/protocols/protocol.dart';
import 'package:i9vate_sales_force/app/validation/validators/validator.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuild.field('email').required().email().build(),
    ...ValidationBuild.field('password').required().build(),
  ];
}

// RequiredFieldValidation('email'),
// EmailValidation('email'),
// RequiredFieldValidation('password'),
