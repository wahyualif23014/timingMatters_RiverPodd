// presentation/pages/finance_overview_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart'; // Import glassmorphism
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class FinanceOverviewPage extends StatelessWidget {
  const FinanceOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the platform is iOS for subtle styling adjustments
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to go behind transparent app bar
      appBar: AppBar(
        title: Text(
          'Finance Overview',
          style: GoogleFonts.inter( // Use Inter font for a clean look
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
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background with Gradient or Image
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
          // Centered Glassmorphism Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 600), delay: Duration(milliseconds: 200)),
                  ScaleEffect(duration: Duration(milliseconds: 600), delay: Duration(milliseconds: 200), curve: Curves.easeOutBack),
                ],
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width * 0.85, // Responsive width
                  height: MediaQuery.of(context).size.height * 0.5, // Responsive height
                  borderRadius: 24,
                  blur: 15, // Stronger blur for a prominent effect
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
                      Text(
                        'Your Financial Hub',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: const Duration(milliseconds: 800), duration: const Duration(milliseconds: 600)),
                      const SizedBox(height: 30),
                      // Navigation Buttons
                      _buildGlassmorphicButton(
                        context,
                        'Go to Budget Page',
                        () => context.push('/budget'),
                        Icons.account_balance_wallet_outlined,
                      ).animate().slideY(begin: 0.5, duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 1000)).fadeIn(delay: const Duration(milliseconds: 1000)),
                      const SizedBox(height: 16),
                      _buildGlassmorphicButton(
                        context,
                        'Go to Financial Goals',
                        () => context.push('/financial-goals'),
                        Icons.track_changes_outlined,
                      ).animate().slideY(begin: 0.5, duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 1200)).fadeIn(delay: const Duration(milliseconds: 1200)),
                      const SizedBox(height: 16),
                      _buildGlassmorphicButton(
                        context,
                        'Add Transaction',
                        () => context.push('/add-transaction'),
                        Icons.add_circle_outline,
                      ).animate().slideY(begin: 0.5, duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 1400)).fadeIn(delay: const Duration(milliseconds: 1400)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent glassmorphic buttons
  Widget _buildGlassmorphicButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    IconData icon,
  ) {
    return Animate(
      effects: const [
        ScaleEffect(duration: Duration(milliseconds: 200), curve: Curves.easeInOut),
      ],
      child: GestureDetector(
        onTapDown: (_) => _handleTapDown(context), // Simple tap animation feedback
        onTapUp: (_) => _handleTapUp(context, onPressed),
        onTapCancel: () => _handleTapCancel(context),
        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 60,
          borderRadius: 16.0,
          blur: 10,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simple animation feedback for button presses
  void _handleTapDown(BuildContext context) {
    // You can trigger a small scale animation here if needed
  }

  void _handleTapUp(BuildContext context, VoidCallback onPressed) {
    onPressed(); // Execute the navigation
  }

  void _handleTapCancel(BuildContext context) {
    // Handle cancel if tap is interrupted
  }
}
