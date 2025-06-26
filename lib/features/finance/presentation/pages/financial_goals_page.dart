// presentation/pages/financial_goals_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import 'package:firebase_core/firebase_core.dart'; // Import for FirebaseException
import '../../data/models/financial_goal_model.dart';
import '../../data/providers/financial_goals_provider.dart';

class FinancialGoalsPage extends ConsumerWidget {
  const FinancialGoalsPage({super.key});

  // Helper function to show a SnackBar
  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financialGoalsAsyncValue = ref.watch(financialGoalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Goals'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: financialGoalsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          // Detect and display specific error messages for the initial data load
          String errorMessage = 'Failed to load goals: ${error.toString()}';
          if (error is FirebaseException) {
            errorMessage = 'Firebase Error: ${error.message ?? error.code}';
          }
          debugPrint('Error loading financial goals: $error\n$stack'); // Log full error for debugging
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  // Optionally, add a retry button
                  ElevatedButton(
                    onPressed: () {
                      // Re-initialize the provider to attempt a reload
                      ref.invalidate(financialGoalsProvider);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (goals) {
          if (goals.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.grey, size: 60),
                    SizedBox(height: 10),
                    Text(
                      'Tidak ada target keuangan yang ditemukan.\nMari tambahkan target pertamamu!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              final progress = goal.targetAmount > 0 ? (goal.savedAmount / goal.targetAmount).clamp(0.0, 1.0) : 0.0;

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Target: \$${goal.targetAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Saved: \$${goal.savedAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        color: Colors.lightGreen,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Progress: ${(progress * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showGoalForm(context, ref, goal: goal),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.green),
                            onPressed: () {
                              _showAddProgressDialog(context, ref, goal);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(context, ref, goal.id, goal.title),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showGoalForm(context, ref),
        label: const Text('Add Goal'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showGoalForm(BuildContext context, WidgetRef ref, {FinancialGoalModel? goal}) {
    final TextEditingController titleController = TextEditingController(text: goal?.title ?? '');
    final TextEditingController targetAmountController = TextEditingController(text: goal?.targetAmount.toString() ?? '');
    final TextEditingController savedAmountController = TextEditingController(text: goal?.savedAmount.toString() ?? '0.0');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(goal == null ? 'Add New Goal' : 'Edit Goal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Goal Title', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: targetAmountController,
                  decoration: const InputDecoration(labelText: 'Target Amount', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                // savedAmount is only set initially for new goals, not editable for existing ones
                if (goal == null) // Show only for adding new goal
                  TextField(
                    controller: savedAmountController,
                    decoration: const InputDecoration(labelText: 'Saved Amount', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim(); // Trim whitespace
                final targetAmount = double.tryParse(targetAmountController.text) ?? 0.0;
                final savedAmount = goal == null ? (double.tryParse(savedAmountController.text) ?? 0.0) : goal.savedAmount; // Only read if new goal

                if (title.isEmpty || targetAmount <= 0) {
                  _showSnackBar(context, 'Judul dan jumlah target harus valid dan lebih dari 0.', isError: true);
                  return;
                }

                final notifier = ref.read(financialGoalsProvider.notifier);
                try {
                  if (goal == null) {
                    // Add new goal
                    final newGoal = FinancialGoalModel(
                      id: const Uuid().v4(), // Generate a unique ID
                      title: title,
                      targetAmount: targetAmount,
                      savedAmount: savedAmount,
                    );
                    await notifier.addGoal(newGoal);
                    _showSnackBar(context, 'Target "${newGoal.title}" berhasil ditambahkan!');
                  } else {
                    // Update existing goal
                    final updates = {
                      'title': title,
                      'targetAmount': targetAmount,
                    };
                    await notifier.updateGoal(goal.id, updates);
                    _showSnackBar(context, 'Target "${goal.title}" berhasil diperbarui!');
                  }
                  Navigator.pop(context);
                } catch (e, st) {
                  String errorMessage = 'Gagal menyimpan target.';
                  if (e is FirebaseException) {
                    errorMessage = 'Kesalahan Firebase: ${e.message ?? e.code}';
                  }
                  debugPrint('Error saving goal: $e\n$st'); // Log full error for debugging
                  _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                }
              },
              child: Text(goal == null ? 'Tambah' : 'Perbarui'),
            ),
          ],
        );
      },
    );
  }

  void _showAddProgressDialog(BuildContext context, WidgetRef ref, FinancialGoalModel goal) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambahkan progres ke "${goal.title}"'),
          content: TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Jumlah yang akan ditambahkan', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final amountToAdd = double.tryParse(amountController.text) ?? 0.0;
                if (amountToAdd <= 0) {
                  _showSnackBar(context, 'Harap masukkan jumlah positif.', isError: true);
                  return;
                }

                try {
                  final newSavedAmount = goal.savedAmount + amountToAdd;
                  await ref.read(financialGoalsProvider.notifier).updateGoalProgress(goal.id, newSavedAmount);
                  _showSnackBar(context, 'Progres berhasil ditambahkan ke "${goal.title}"!');
                  Navigator.pop(context);
                } catch (e, st) {
                  String errorMessage = 'Gagal menambahkan progres.';
                  if (e is FirebaseException) {
                    errorMessage = 'Kesalahan Firebase: ${e.message ?? e.code}';
                  }
                  debugPrint('Error adding progress: $e\n$st'); // Log full error for debugging
                  _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: Text('Apakah Anda yakin ingin menghapus target "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(financialGoalsProvider.notifier).deleteGoal(id);
                  _showSnackBar(context, 'Target "$title" berhasil dihapus!');
                  Navigator.pop(context);
                } catch (e, st) {
                  String errorMessage = 'Gagal menghapus target.';
                  if (e is FirebaseException) {
                    errorMessage = 'Kesalahan Firebase: ${e.message ?? e.code}';
                  }
                  debugPrint('Error deleting goal: $e\n$st'); // Log full error for debugging
                  _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
