import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/transaction.dart' as M;

class Transaction extends ChangeNotifier {
  List<M.Transaction> _userTransactions = [
    M.Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    M.Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    M.Transaction(
      id: 't3',
      title: 'Buy a coffee',
      amount: 60.69,
      date: DateTime.now().subtract(
        Duration(days: 1),
      ),
    ),
    M.Transaction(
      id: 't4',
      title: 'Buy a milk',
      amount: 40,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
  ];

  List<M.Transaction> get userTransaction => _userTransactions;

  void set userTransaction(List<M.Transaction> userTransaction) {
    _userTransactions = userTransaction;
  }

  List<M.Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  M.Transaction findTransaction(String id) {
    return userTransaction.firstWhere((u) => u.id == id);
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = M.Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    _userTransactions.add(newTx);
    notifyListeners();
  }

  void updateTransaction(
      String txTitle, double txAmount, DateTime chosenDate, String id) {
    M.Transaction existingTransaction =
        userTransaction.firstWhere((u) => u.id == id);

    existingTransaction.title = txTitle;
    existingTransaction.amount = txAmount;
    existingTransaction.date = chosenDate;
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _userTransactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
