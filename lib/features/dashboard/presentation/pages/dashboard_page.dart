import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Timing Matters'),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Glass Cards
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  // GlassDashboardTile(
                  //   title: 'Finance',
                  //   icon: Icons.account_balance_wallet,
                  //   onTap: () => context.push(Routes.financeOverview),
                  // ),
                  // GlassDashboardTile(
                  //   title: 'Habits',
                  //   icon: Icons.check_circle_outline,
                  //   onTap: () => context.push(Routes.habits),
                  // ),
                  // GlassDashboardTile(
                  //   title: 'Calendar',
                  //   icon: Icons.calendar_today,
                  //   onTap: () => context.push(Routes.calendar),
                  // ),
                  // GlassDashboardTile(
                  //   title: 'Activities',
                  //   icon: Icons.local_activity,
                  //   onTap: () => context.push(Routes.activities),
                  // ),
                  // GlassDashboardTile(
                  //   title: 'Settings',
                  //   icon: Icons.settings,
                  //   onTap: () => context.push(Routes.settings),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassDashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const GlassDashboardTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.white, size: 28),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
