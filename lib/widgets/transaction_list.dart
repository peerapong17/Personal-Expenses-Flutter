import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/services/transaction_service.dart';
import 'package:flutter_complete_guide/states/transaction_state.dart';
import 'package:flutter_complete_guide/utils/present_dialog.dart';
import 'package:flutter_complete_guide/utils/present_transaction_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Transaction transactionSt = Provider.of<Transaction>(context);
    return transactionSt.userTransaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactionSt.userTransaction.length,
            itemBuilder: (ctx, index) {
              var userTransaction = transactionSt.userTransaction[index];
              return GestureDetector(
                onTap: () =>
                    presentTransactionForm(context, userTransaction.id),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink.shade200,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${userTransaction.amount}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransaction.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransaction.date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            onPressed: () async {
                              final value = await presentDialog(context);
                              if (value == "true") {
                                transactionSt
                                    .deleteTransaction(userTransaction.id);
                              }
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            color: Theme.of(context).errorColor,
                            onPressed: () async {
                              final String value = await presentDialog(context);
                              if (value == "true") {
                                transactionSt
                                    .deleteTransaction(userTransaction.id);
                              }
                            },
                          ),
                  ),
                ),
              );
            },
          );
  }
}
