// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:timming_matters/core/extensions/context_extension.dart';
// import 'package:timming_matters/features/finance/data/providers/finance_provider';
// import '../../data/models/transaction_model.dart';
// import '../../../finance/data/providers/transaction_provider.dart';

// class AddTransactionPage extends ConsumerStatefulWidget {
//   final TransactionModel? transaction; // Untuk edit mode
  
//   const AddTransactionPage({
//     super.key,
//     this.transaction,
//   });

//   @override
//   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// }

// class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//   final _categoryController = TextEditingController();
  
//   String _transactionType = 'Income';
//   DateTime _selectedDate = DateTime.now();
//   bool _isLoading = false;
  
//   // Categories for dropdown
//   final List<String> _incomeCategories = [
//     'Salary',
//     'Business',
//     'Investment',
//     'Gift',
//     'Bonus',
//     'Other Income',
//   ];
  
//   final List<String> _expenseCategories = [
//     'Food',
//     'Transportation',
//     'Shopping',
//     'Bills',
//     'Entertainment',
//     'Health',
//     'Education',
//     'Travel',
//     'Other Expense',
//   ];

//   @override
//   void initState() {
//     super.initState();
    
//     // Jika dalam mode edit, isi form dengan data existing
//     if (widget.transaction != null) {
//       _titleController.text = widget.transaction!.description;
//       _amountController.text = widget.transaction!.amount.toString();
//       _categoryController.text = widget.transaction!.category;
//       _transactionType = widget.transaction!.isIncome ? 'Income' : 'Expense';
//       _selectedDate = widget.transaction!.date;
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _amountController.dispose();
//     _categoryController.dispose();
//     super.dispose();
//   }

//   List<String> get _currentCategories {
//     return _transactionType == 'Income' ? _incomeCategories : _expenseCategories;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditMode = widget.transaction != null;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEditMode ? 'Edit Transaction' : 'Add Transaction'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.pop(),
//         ),
//         actions: [
//           if (isEditMode)
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: _showDeleteConfirmation,
//             ),
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Title Field
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.title),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
              
//               const SizedBox(height: 16),
              
//               // Amount Field
//               TextFormField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.attach_money),
//                   prefixText: 'Rp ',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   if (double.tryParse(value) == null || double.parse(value) <= 0) {
//                     return 'Please enter a valid amount';
//                   }
//                   return null;
//                 },
//               ),
              
//               const SizedBox(height: 16),
              
//               // Transaction Type (Income/Expense)
//               DropdownButtonFormField<String>(
//                 value: _transactionType,
//                 decoration: const InputDecoration(
//                   labelText: 'Type',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.swap_vert),
//                 ),
//                 items: const [
//                   DropdownMenuItem(value: 'Income', child: Text('Income')),
//                   DropdownMenuItem(value: 'Expense', child: Text('Expense')),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     _transactionType = value!;
//                     _categoryController.clear(); // Clear category when type changes
//                   });
//                 },
//               ),
              
//               const SizedBox(height: 16),
              
//               // Category Field
//               DropdownButtonFormField<String>(
//                 value: _currentCategories.contains(_categoryController.text) 
//                     ? _categoryController.text 
//                     : null,
//                 decoration: const InputDecoration(
//                   labelText: 'Category',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.category),
//                 ),
//                 items: _currentCategories.map((category) {
//                   return DropdownMenuItem(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   _categoryController.text = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select a category';
//                   }
//                   return null;
//                 },
//               ),
              
//               const SizedBox(height: 16),
              
//               // Date Picker
//               InkWell(
//                 onTap: _selectDate,
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.calendar_today),
//                       const SizedBox(width: 12),
//                       Text(
//                         'Date: ${_formatDate(_selectedDate)}',
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       const Spacer(),
//                       const Icon(Icons.arrow_drop_down),
//                     ],
//                   ),
//                 ),
//               ),
              
//               const SizedBox(height: 32),
              
//               // Save Button
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _saveTransaction,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: _transactionType == 'Income' 
//                       ? Colors.green 
//                       : Colors.red,
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                         isEditMode ? 'Update Transaction' : 'Add Transaction',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
//   }

//   Future<void> _saveTransaction() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final transactionService = ref.read(financeRepositoryProvider);
      
//       if (widget.transaction == null) {
//         // Add new transaction
//         await transactionService.addTransaction(
//           TransactionModel(
//             id: '', // or generate a new id if required
//             description: _titleController.text.trim(),
//             amount: double.parse(_amountController.text),
//             date: _selectedDate,
//             category: _categoryController.text,
//             isIncome: _transactionType == 'Income',
//           ),
//         );
        
//         if (mounted) {
//           _showSuccessSnackBar('Transaction added successfully');
//         }
//       } else {
//         // Update existing transaction
//         final updatedTransaction = TransactionModel(
//           id: widget.transaction!.id,
//           description: _titleController.text.trim(),
//           amount: double.parse(_amountController.text),
//           date: _selectedDate,
//           category: _categoryController.text,
//           isIncome: _transactionType == 'Income',
//         );
        
//         await transactionService.updateTransaction(updatedTransaction);
        
//         if (mounted) {
//           _showSuccessSnackBar('Transaction updated successfully');
//         }
//       }
      
//       if (mounted) {
//         context.pop();
//       }
//     } catch (e) {
//       if (mounted) {
//         _showErrorSnackBar('Failed to save transaction: $e');
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   Future<void> _showDeleteConfirmation() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Transaction'),
//         content: Text(
//           'Are you sure you want to delete "${widget.transaction?.description}"?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       await _deleteTransaction();
//     }
//   }

//   Future<void> _deleteTransaction() async {
//     if (widget.transaction == null) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final transactionService = ref.read(financeRepositoryProvider);
//       await transactionService.deleteTransaction(widget.transaction!.id);
      
//       if (mounted) {
//         _showSuccessSnackBar('Transaction deleted successfully');
//         context.pop();
//       }
//     } catch (e) {
//       if (mounted) {
//         _showErrorSnackBar('Failed to delete transaction: $e');
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }