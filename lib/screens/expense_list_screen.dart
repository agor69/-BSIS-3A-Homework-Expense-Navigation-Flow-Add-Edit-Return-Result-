import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_item.dart';
import 'add_expense_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Expense> _expenses = [
    Expense(title: "Lunch", amount: 120),
    Expense(title: "Coffee", amount: 80),
    Expense(title: "Transport", amount: 15),
  ];

  Future<void> _addExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
    );

    if (result != null && result is Expense) {
      setState(() {
        _expenses.add(result);
      });
    }
  }

  Future<void> _editExpense(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddExpenseScreen(expense: _expenses[index]),
      ),
    );

    if (result != null && result is Expense) {
      setState(() {
        _expenses[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        child: const Icon(Icons.add),
      ),
      body: _expenses.isEmpty
          ? const Center(
              child: Text(
                "No expenses yet\nTap + to add one",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                return ExpenseItem(
                  expense: _expenses[index],
                  onTap: () => _editExpense(index),
                );
              },
            ),
    );
  }
}
