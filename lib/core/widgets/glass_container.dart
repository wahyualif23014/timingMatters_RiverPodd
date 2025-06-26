// presentation/widgets/glass_container.dart
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final double border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry alignment;
  final List<Color>? linearGradientColors;
  final List<Color>? borderGradientColors;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16, // Default radius for consistency
    this.blur = 10,       // Default blur intensity
    this.border = 1.5,    // Default border width
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.linearGradientColors,
    this.borderGradientColors,
  });

  @override
  Widget build(BuildContext context) {
    // Default blue-ish glassmorphism colors
    final defaultLinearGradientColors = [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.02),
    ];
    final defaultBorderGradientColors = [
      Colors.white.withOpacity(0.4),
      Colors.white.withOpacity(0.01),
    ];

    return Container(
      margin: margin,
      child: GlassmorphicContainer(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        borderRadius: borderRadius,
        blur: blur,
        alignment: alignment,
        border: border,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: linearGradientColors ?? defaultLinearGradientColors,
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: borderGradientColors ?? defaultBorderGradientColors,
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero, // Apply padding if provided
          child: child,
        ),
      ),
    );
  }
}
