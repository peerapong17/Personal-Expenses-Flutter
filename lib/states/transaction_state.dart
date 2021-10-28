import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

class TransactionState extends ChangeNotifier {
  List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Buy a coffee',
      amount: 60.69,
      date: DateTime.now().subtract(
        Duration(days: 1),
      ),
    ),
    Transaction(
      id: 't4',
      title: 'Buy a milk',
      amount: 40,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
  ];

  List<Transaction> get userTransaction => _userTransactions;

  void set userTransaction(List<Transaction> userTransaction) {
    _userTransactions = userTransaction;
  }

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    _userTransactions.add(newTx);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _userTransactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
