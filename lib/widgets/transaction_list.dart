import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/states/transaction_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionState tscState =
        Provider.of<TransactionState>(context, listen: false);
    return tscState.userTransaction.isEmpty
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
            itemCount: tscState.userTransaction.length,
            itemBuilder: (ctx, index) {
              var userTsc = tscState.userTransaction[index];
              return Card(
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
                        child: Text('\$${userTsc.amount}', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  title: Text(
                    userTsc.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTsc.date),
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
                          onPressed: () => tscState.deleteTransaction(
                            userTsc.id,
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () => tscState.deleteTransaction(
                            userTsc.id,
                          ),
                        ),
                ),
              );
            },
          );
  }
}
