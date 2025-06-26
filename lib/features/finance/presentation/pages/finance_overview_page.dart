import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FinanceOverviewPage extends StatelessWidget {
  const FinanceOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Overview'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/budget'),
              child: const Text('Go to Budget Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/financial-goals'),
              child: const Text('Go to Financial Goals Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/add-transaction'),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}