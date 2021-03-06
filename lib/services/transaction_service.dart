import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_form.dart';

class TransactionService {
  static void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: TransactionForm(null),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
