import 'package:flutter/material.dart';

presentSnackBar(BuildContext context, Function() callback) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Transaction was deleted!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: callback,
      ),
    ),
  );
}
