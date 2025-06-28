// presentation/widgets/glass_container.dart
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry alignment;
  final List<Color>? linearGradientColors;
  final List<Color>? borderGradientColors;
  final BoxBorder? customBorder;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.opacity = 0.1, // Default opacity for a subtle glass effect
    this.borderRadius = 16,
    this.blur = 10,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.linearGradientColors,
    this.borderGradientColors,
    this.customBorder,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> resolvedLinearGradientColors = linearGradientColors ?? [
      Colors.white.withOpacity(opacity * 0.8),
      Colors.grey.withOpacity(opacity * 0.4),
    ];

    final List<Color> resolvedBorderGradientColors = borderGradientColors ?? [
      Colors.white.withOpacity(0.4),
      Colors.white.withOpacity(0.1),
    ];

    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        border: customBorder,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: GlassmorphicContainer(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: 0, // Handled by ClipRRect
          blur: blur,
          alignment: alignment,
          border: 0, // Handled by customBorder in outer Container
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: resolvedLinearGradientColors,
          ),
          borderGradient: customBorder == null
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: resolvedBorderGradientColors,
                )
              : const LinearGradient(colors: [Colors.transparent, Colors.transparent]), // No border gradient if customBorder is provided
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}