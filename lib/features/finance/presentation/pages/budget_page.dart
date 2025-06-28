// lib/presentation/pages/budget_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:timming_matters/core/widgets/glass_container.dart';
import 'package:timming_matters/features/finance/data/providers/finance_provider';

import '../../data/models/budget_model.dart';

class BudgetPage extends ConsumerStatefulWidget {
  const BudgetPage({super.key});

  @override
  ConsumerState<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends ConsumerState<BudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();

  BudgetModel? _editingBudget;

  @override
  void dispose() {
    _categoryController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  void _showBudgetForm({BudgetModel? budget}) {
    setState(() {
      _editingBudget = budget;
      if (budget != null) {
        _categoryController.text = budget.category;
        _limitController.text = budget.limit.toString();
      } else {
        _categoryController.clear();
        _limitController.clear();
      }
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GlassContainer(
            borderRadius: 30,
            blur: 20,
            opacity: 0.2,
            linearGradientColors: [
              Colors.white.withOpacity(0.3),
              Colors.grey[800]!.withOpacity(0.2),
            ],
            customBorder: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      budget == null ? 'Add New Budget' : 'Edit Budget',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _categoryController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.white70),
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red.withOpacity(0.6)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Category cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _limitController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Limit',
                        labelStyle: TextStyle(color: Colors.white70),
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red.withOpacity(0.6)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Limit cannot be empty';
                        }
                        if (double.tryParse(value) == null || double.parse(value) <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700]?.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveBudget();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.withOpacity(0.7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              budget == null ? 'Add' : 'Save',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _saveBudget() async {
    final newBudget = BudgetModel(
      id: _editingBudget?.id ?? UniqueKey().toString(),
      category: _categoryController.text,
      limit: double.parse(_limitController.text),
      spent: _editingBudget?.spent ?? 0.0,
    );

    if (_editingBudget == null) {
      final addFuture = ref.read(addBudgetProvider(newBudget).future);
      addFuture.then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget added successfully!', style: TextStyle(color: Colors.white))),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add budget: $error', style: TextStyle(color: Colors.white))),
        );
      });
    } else {
      final updateFuture = ref.read(updateBudgetProvider(newBudget).future);
      updateFuture.then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget updated successfully!', style: TextStyle(color: Colors.white))),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update budget: $error', style: TextStyle(color: Colors.white))),
        );
      });
    }
  }

  void _deleteBudget(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Budget?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Are you sure you want to delete this budget? Deleting a budget will not remove associated expenses.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final deleteFuture = ref.read(deleteBudgetProvider(id).future);
              deleteFuture.then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Budget deleted successfully!', style: TextStyle(color: Colors.white))),
                );
                Navigator.pop(context);
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete budget: $error', style: TextStyle(color: Colors.white))),
                );
                Navigator.pop(context);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgetsAsyncValue = ref.watch(budgetsStreamProvider);

    // Calculate AppBar height including status bar
    final double appBarHeight = AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Budget Management',
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Make AppBar itself transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Remove flexibleSpace here to avoid GlassmorphicContainer issues
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[900]!,
              Colors.black.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack( // Use a Stack to place the blur effect behind the AppBar content
          children: [
            // Background Blur Effect for the AppBar area
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: appBarHeight, // Match AppBar's height
              child: GlassContainer(
                borderRadius: 0,
                blur: 15,
                opacity: 0.1,
                linearGradientColors: [
                  Colors.grey[900]!.withOpacity(0.7),
                  Colors.grey[800]!.withOpacity(0.5),
                ],
                customBorder: null,
                child: const SizedBox.expand(),
              ),
            ),
            // The actual content (ListView)
            budgetsAsyncValue.when(
              data: (budgets) {
                if (budgets.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: appBarHeight + 20), // Adjust padding for content below blurred area
                      child: Text(
                        'No budgets yet. Add your first budget!',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: appBarHeight + 20, // Start content below the blurred AppBar area
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  itemCount: budgets.length,
                  itemBuilder: (context, index) {
                    final budget = budgets[index];
                    final percentageSpent = (budget.limit > 0) ? (budget.spent / budget.limit) : 0.0;
                    Color progressBarColor = Colors.greenAccent;
                    if (percentageSpent > 0.8) {
                      progressBarColor = Colors.redAccent;
                    } else if (percentageSpent > 0.5) {
                      progressBarColor = Colors.orangeAccent;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GlassContainer(
                        borderRadius: 20,
                        blur: 15,
                        opacity: 0.15,
                        linearGradientColors: [
                          Colors.white.withOpacity(0.15),
                          Colors.grey[700]!.withOpacity(0.1),
                        ],
                        customBorder: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          title: Text(
                            budget.category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Spent: Rp${NumberFormat.currency(locale: 'id_ID', symbol: '').format(budget.spent)} / Limit: Rp${NumberFormat.currency(locale: 'id_ID', symbol: '').format(budget.limit)}',
                                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: percentageSpent.clamp(0.0, 1.0),
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${(percentageSpent * 100).toStringAsFixed(1)}% used',
                                style: TextStyle(
                                  color: progressBarColor.withOpacity(0.9),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blueAccent.withOpacity(0.9)),
                                onPressed: () => _showBudgetForm(budget: budget),
                                tooltip: 'Edit Budget',
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.redAccent.withOpacity(0.9)),
                                onPressed: () => _deleteBudget(budget.id),
                                tooltip: 'Delete Budget',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.only(top: appBarHeight + 20),
                  child: const CircularProgressIndicator(color: Colors.white),
                ),
              ),
              error: (err, stack) => Center(
                child: Padding(
                  padding: EdgeInsets.only(top: appBarHeight + 20),
                  child: Text('Error: $err', style: TextStyle(color: Colors.red, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBudgetForm(),
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        tooltip: 'Add New Budget',
      ),
    );
  }
}