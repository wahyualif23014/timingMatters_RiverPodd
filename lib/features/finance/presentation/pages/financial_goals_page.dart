// presentation/pages/financial_goals_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart'; 
import 'package:firebase_core/firebase_core.dart';
import '../../data/models/financial_goal_model.dart';
import '../../data/providers/financial_goals_provider.dart';
import 'package:glassmorphism/glassmorphism.dart'; 
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart'; 

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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final mediaQueryData = MediaQuery.of(context);
    final safeAreaBottom = mediaQueryData.padding.bottom;
    final appBarHeight = kToolbarHeight; // Standard AppBar height

    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to go behind transparent app bar
      appBar: AppBar(
        title: Text(
          'Financial Goals',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            isIOS ? Icons.arrow_back_ios : Icons.arrow_back, // iOS-style back arrow
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background with Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A237E), // Deep Indigo
                  Color(0xFF42A5F5), // Light Blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          financialGoalsAsyncValue.when(
            loading: () => Center(
              child: const CircularProgressIndicator(color: Colors.white).animate().fadeIn(duration: 500.ms),
            ),
            error: (error, stack) {
              String errorMessage = 'Failed to load goals: ${error.toString()}';
              if (error is FirebaseException) {
                errorMessage = 'Firebase Error: ${error.message ?? error.code}';
              }
              debugPrint('Error loading financial goals: $error\n$stack'); // Log full error for debugging
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Animate(
                    effects: [FadeEffect(duration: 600.ms), ScaleEffect(duration: 600.ms, curve: Curves.easeOutBack)],
                    child: GlassmorphicContainer(
                      width: mediaQueryData.size.width * 0.8,
                      height: mediaQueryData.size.height * 0.35,
                      borderRadius: 24,
                      blur: 15,
                      alignment: Alignment.center,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red.withOpacity(0.15),
                          Colors.red.withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red.withOpacity(0.5),
                          Colors.red.withOpacity(0.05),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.white, size: 50).animate().shake(hz: 2, curve: Curves.easeInOut),
                          const SizedBox(height: 16),
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(financialGoalsProvider);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            data: (goals) {
              if (goals.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Animate(
                      effects: [FadeEffect(duration: 600.ms), SlideEffect(begin: Offset(0, 0.2), duration: 600.ms, curve: Curves.easeOutCubic)],
                      child: GlassmorphicContainer(
                        width: mediaQueryData.size.width * 0.8,
                        height: mediaQueryData.size.height * 0.35,
                        borderRadius: 24,
                        blur: 15,
                        alignment: Alignment.center,
                        border: 2,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lightbulb_outline, color: Colors.white, size: 60),
                            const SizedBox(height: 16),
                            Text(
                              'Tidak ada target keuangan yang ditemukan.\nMari tambahkan target pertamamu!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                // Use a slightly larger bottom padding to ensure it clears the FAB
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  appBarHeight + mediaQueryData.padding.top + 20, // Dynamic top padding
                  16.0,
                  safeAreaBottom + 90.0, // Increased bottom padding for FAB clearance
                ),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  final progress = goal.targetAmount > 0 ? (goal.savedAmount / goal.targetAmount).clamp(0.0, 1.0) : 0.0;

                  return Animate(
                    effects: [
                      FadeEffect(duration: 500.ms, delay: (50 * index).ms),
                      SlideEffect(begin: const Offset(0, 0.5), duration: 500.ms, delay: (50 * index).ms, curve: Curves.easeOutCubic),
                    ],
                    child: GlassmorphicContainer(
                      width: double.infinity,
                      height: 220,
                      borderRadius: 16,
                      blur: 10,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      border: 1.5,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.02),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.01),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Target: Rp${goal.targetAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                            ),
                            Text(
                              'Saved: Rp${goal.savedAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                            ),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              color: Colors.lightGreenAccent,
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Progress: ${(progress * 100).toStringAsFixed(1)}%',
                              style: GoogleFonts.inter(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.7)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildGlassyIconButton(context, Icons.edit, Colors.blueAccent, () => _showGoalForm(context, ref, goal: goal), tooltip: 'Edit Goal'),
                                _buildGlassyIconButton(context, Icons.add, Colors.lightGreenAccent, () { _showAddProgressDialog(context, ref, goal); }, tooltip: 'Add Progress'),
                                _buildGlassyIconButton(context, Icons.delete, Colors.redAccent, () => _confirmDelete(context, ref, goal.id, goal.title), tooltip: 'Delete Goal'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: Animate(
        effects: [FadeEffect(duration: 500.ms, delay: 1000.ms), ScaleEffect(duration: 500.ms, delay: 1000.ms, curve: Curves.easeOutBack)],
        child: FloatingActionButton.extended(
          onPressed: () => _showGoalForm(context, ref),
          label: Text('Add Goal', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Modified to include tooltip parameter
  Widget _buildGlassyIconButton(BuildContext context, IconData icon, Color color, VoidCallback onPressed, {String? tooltip}) {
    return Animate(
      effects: [ScaleEffect(duration: 200.ms, curve: Curves.easeInOut)],
      child: IconButton(
        icon: Icon(icon, color: color.withOpacity(0.8), size: 28),
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }

  // Dialogs with Glassmorphism Theme
  void _showGoalForm(BuildContext context, WidgetRef ref, {FinancialGoalModel? goal}) {
    final TextEditingController titleController = TextEditingController(text: goal?.title ?? '');
    final TextEditingController targetAmountController = TextEditingController(text: goal?.targetAmount.toString() ?? '');
    final TextEditingController savedAmountController = TextEditingController(text: goal?.savedAmount.toString() ?? '0.0');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.85,
            height: goal == null ? 420 : 360,
            borderRadius: 24,
            blur: 15,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.withOpacity(0.15),
                Colors.blueGrey.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.05),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    goal == null ? 'Add New Goal' : 'Edit Goal',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Goal Title',
                      labelStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.7)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: targetAmountController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Target Amount',
                      labelStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.7)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  if (goal == null)
                    TextField(
                      controller: savedAmountController,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Saved Amount',
                        labelStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(foregroundColor: Colors.white.withOpacity(0.7)),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () async {
                          final title = titleController.text.trim();
                          final targetAmount = double.tryParse(targetAmountController.text) ?? 0.0;
                          final savedAmount = goal == null ? (double.tryParse(savedAmountController.text) ?? 0.0) : goal.savedAmount;

                          if (title.isEmpty || targetAmount <= 0) {
                            _showSnackBar(context, 'Judul dan jumlah target harus valid dan lebih dari 0.', isError: true);
                            return;
                          }

                          final notifier = ref.read(financialGoalsProvider.notifier);
                          try {
                            if (goal == null) {
                              final newGoal = FinancialGoalModel(
                                id: const Uuid().v4(),
                                title: title,
                                targetAmount: targetAmount,
                                savedAmount: savedAmount,
                              );
                              await notifier.addGoal(newGoal);
                              _showSnackBar(context, 'Target "${newGoal.title}" berhasil ditambahkan!');
                            } else {
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
                            debugPrint('Error saving goal: $e\n$st');
                            _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(goal == null ? 'Add ' : 'Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 280,
            borderRadius: 24,
            blur: 15,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.withOpacity(0.15),
                Colors.blueGrey.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.05),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tambahkan progres ke "${goal.title}"',
                    style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: amountController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Jumlah yang akan ditambahkan',
                      labelStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.7)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(foregroundColor: Colors.white.withOpacity(0.7)),
                        child: const Text('Batal'),
                      ),
                      const SizedBox(width: 12),
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
                            debugPrint('Error adding progress: $e\n$st');
                            _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 250,
            borderRadius: 24,
            blur: 15,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.withOpacity(0.15),
                Colors.blueGrey.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.05),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Konfirmasi Penghapusan',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Apakah Anda yakin ingin menghapus target "$title"?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(foregroundColor: Colors.white.withOpacity(0.7)),
                        child: const Text('Batal'),
                      ),
                      const SizedBox(width: 12),
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
                            debugPrint('Error deleting goal: $e\n$st');
                            _showSnackBar(context, '$errorMessage Mohon coba lagi.', isError: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Hapus', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}