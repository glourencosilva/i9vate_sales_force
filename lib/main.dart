import 'package:flutter/material.dart';
import 'package:i9vate_sales_force/app/main/main.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MainApp());
}
