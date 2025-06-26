// core/extensions/context_extension.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

extension ContextExtension on BuildContext {
  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  
  // MediaQuery shortcuts
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  
  // Responsive helpers
  bool get isMobile => screenWidth < 768;
  bool get isTablet => screenWidth >= 768 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  bool get isSmallScreen => screenWidth < 600;
  bool get isLargeScreen => screenWidth > 1200;
  
  // Orientation helpers
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;
  
  // Keyboard helpers
  bool get isKeyboardOpen => viewInsets.bottom > 0;
  double get keyboardHeight => viewInsets.bottom;
  
  // Safe area helpers
  double get statusBarHeight => padding.top;
  double get bottomBarHeight => padding.bottom;
  double get safeHeight => screenHeight - statusBarHeight - bottomBarHeight;
  
  // Responsive spacing
  double get spacingXS => AppConstants.spacingXS;
  double get spacingS => AppConstants.spacingS;
  double get spacingM => AppConstants.spacingM;
  double get spacingL => AppConstants.spacingL;
  double get spacingXL => AppConstants.spacingXL;
  double get spacingXXL => AppConstants.spacingXXL;
  
  // Responsive text sizes
  double get textSizeSmall => isMobile ? 12 : 14;
  double get textSizeMedium => isMobile ? 14 : 16;
  double get textSizeLarge => isMobile ? 16 : 18;
  double get textSizeXL => isMobile ? 20 : 24;
  double get textSizeXXL => isMobile ? 24 : 32;
  
  // Custom colors from theme
  Color get primaryColor => AppConstants.primaryColor;
  Color get secondaryColor => AppConstants.secondaryColor;
  Color get accentColor => AppConstants.accentColor;
  Color get successColor => AppConstants.successColor;
  Color get warningColor => AppConstants.warningColor;
  Color get errorColor => AppConstants.errorColor;
  
  // Glass effect colors
  Color get glassBackground => AppConstants.glassBackground;
  Color get glassBorder => AppConstants.glassBorder;
  
  // Navigation helpers
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
  
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }
  
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  void pop([Object? result]) {
    Navigator.of(this).pop(result);
  }
  
  bool canPop() {
    return Navigator.of(this).canPop();
  }
  
  // Snackbar helpers
  void showSnackBar(
    String message, {
    SnackBarAction? action,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
    );
  }
  
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: successColor,
    );
  }
  
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: errorColor,
    );
  }
  
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: warningColor,
    );
  }
  
  // Dialog helpers
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (context) => child,
    );
  }
  
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showCustomDialog<bool>(
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
  
  // Bottom sheet helpers
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }
  
  // Focus helpers
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
  
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }
  
  // Haptic feedback helpers
  void lightHaptic() {
    HapticFeedback.lightImpact();
  }
  
  void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }
  
  void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }
  
  void selectionHaptic() {
    HapticFeedback.selectionClick();
  }
}