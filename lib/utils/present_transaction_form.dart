import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_form.dart';

presentTransactionForm(BuildContext ctx, [String? id = null]) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: TransactionForm(id),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }