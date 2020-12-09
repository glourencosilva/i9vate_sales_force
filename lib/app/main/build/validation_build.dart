import 'package:i9vate_sales_force/app/validation/validators/email_validator.dart';
import 'package:i9vate_sales_force/app/validation/validators/protocols/field_validation.dart';
import 'package:i9vate_sales_force/app/validation/validators/required_field_validation.dart';

class ValidationBuild {
  static ValidationBuild _instance;
  String fieldName;
  List<FieldValidation> validation = [];

  ValidationBuild._();

  static ValidationBuild field(String fieldName) {
    _instance = ValidationBuild._();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuild required() {
    validation.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuild email() {
    validation.add(EmailValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validation;
}
