// import 'package:flutter/material.dart';
// import '../../data/models/financial_goal_model.dart';
// import '../../data/providers/financial_goals_provider.dart'
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FinancialGoalsPage extends ConsumerWidget {
//   const FinancialGoalsPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final goals = ref.watch(financialGoalsProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Financial Goals'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implementasi tambah tujuan keuangan
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Add Financial Goal'),
//               content: TextField(
//                 controller: TextEditingController(),
//                 decoration: const InputDecoration(hintText: 'Enter goal title'),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Simpan data ke provider atau database
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Save'),
//                 ),
//               ],
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: ListView.builder(
//         itemCount: goals.length,
//         itemBuilder: (context, index) {
//           final goal = goals[index];
//           return ListTile(
//             title: Text(goal.title),
//             subtitle: Text('Saved: \$${goal.savedAmount} / Target: \$${goal.targetAmount}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     // Implementasi edit tujuan keuangan
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () {
//                     // Implementasi hapus tujuan keuangan
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }