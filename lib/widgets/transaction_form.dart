import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/states/transaction_state.dart';
import 'package:flutter_complete_guide/utils/present_date_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as M;
import '../widgets/adaptive_flat_button.dart';

class TransactionForm extends StatefulWidget {
  final String? id;

  TransactionForm(this.id);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  DateTime? _selectedDate;
  bool _isInit = true;

  void _addData() {
    if (_key.currentState!.validate() && _selectedDate != null) {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      Provider.of<Transaction>(context, listen: false).addNewTransaction(
        enteredTitle,
        enteredAmount,
        _selectedDate!,
      );

      Navigator.of(context).pop();
    }
  }

  void _updateData() {
    if (_key.currentState!.validate() && _selectedDate != null) {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      Provider.of<Transaction>(context, listen: false).updateTransaction(
          enteredTitle, enteredAmount, _selectedDate!, widget.id!);

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() async {
    final value = await presentDatePicker(context);

    if (value != null) {
      setState(() {
        _selectedDate = value;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      if (widget.id != null) {
        M.Transaction _transaction =
            Provider.of<Transaction>(context).findTransaction(widget.id!);

        _titleController.text = _transaction.title;
        _amountController.text = _transaction.amount.toString();
        _selectedDate = _transaction.date;
      }
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  validator:
                      RequiredValidator(errorText: "Please provide a title"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide an amount of transaction";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please provide a valid number";
                    }
                    if (double.parse(value) <= 0) {
                      return "Please provide an amount of number greater than 0";
                    }
                    return null;
                  },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                        ),
                      ),
                      AdaptiveFlatButton('Choose Date', _presentDatePicker)
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text('Add Transaction'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: TextStyle(
                        color: Theme.of(context).textTheme.button!.color),
                  ),
                  onPressed: widget.id != null ? _updateData : _addData ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
