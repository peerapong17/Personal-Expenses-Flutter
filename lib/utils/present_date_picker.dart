import 'package:flutter/material.dart';

Future<DateTime?> presentDatePicker(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2019),
    lastDate: DateTime.now(),
  );
}
