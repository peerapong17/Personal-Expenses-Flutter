import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/chart_data.dart';
import 'package:flutter_complete_guide/screens/overall_chart_bar.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<ChartData> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // var totalSum = 0.0;

      // for (var item in recentTransactions) {
      //   if (item.date.day == weekDay.day &&
      //       item.date.month == weekDay.month &&
      //       item.date.year == weekDay.year) {
      //     totalSum += item.amount;
      //   }
      // }

      double totalSum() {
        return recentTransactions.fold(
          0.0,
          (sum, item) {
            if (item.date.day == weekDay.day &&
                item.date.month == weekDay.month &&
                item.date.year == weekDay.year) {
              return sum + item.amount;
            } else {
              return sum + 0.0;
            }
          },
        );
      }

      // print(totalSum());

      return ChartData(DateFormat.E().format(weekDay), totalSum());
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.recentTransactions);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OverallChartBar(groupedTransactionValues),
          ),
        );
      },
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data.day,
                  data.amount,
                  totalSpending == 0.0 ? 0.0 : (data.amount) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
