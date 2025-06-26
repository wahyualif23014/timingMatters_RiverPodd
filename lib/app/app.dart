import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';
import '../features/settings/data/providers/settings_provider.dart';

class TimingMattersApp extends ConsumerWidget {
  const TimingMattersApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Timing Matters',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.when(
        data: (data) => data.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        loading: () => ThemeMode.system,
        error: (_, __) => ThemeMode.system,
      ),
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}