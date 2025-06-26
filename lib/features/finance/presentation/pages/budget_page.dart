import 'package:flutter/material.dart';
import 'package:timming_matters/core/extensions/context_extension.dart';
import '../../data/models/budget_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// If not already defined in budget_provider.dart, define it here for demo purposes:
final budgetProvider = StateProvider<List<BudgetModel>>((ref) => []);

class BudgetPage extends ConsumerWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementasi tambah budget
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Budget'),
              content: TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(hintText: 'Enter budget name'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Simpan data ke provider atau database
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          final budget = budgets[index];
          return ListTile(
            title: Text(budget.category),
            subtitle: Text('Spent: \$${budget.spent} / Limit: \$${budget.limit}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Implementasi edit budget
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Implementasi hapus budget
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}