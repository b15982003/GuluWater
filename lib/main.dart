import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/provider/color_seed_provider.dart';
import 'core/routes/routes.dart';
import 'core/theme/gu_direct.dart';
import 'di/setup_db_helper.dart';
import 'feature/main_app.dart';
import 'feature/add_record/add_record_page.dart';
import 'feature/privacy/privacy_page.dart';
import 'feature/target_setting/target_setting_page.dart';
import 'feature/theme_setting/theme_setting_page.dart';

Future<void> main() async {
  await setupDbHelper();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(colorSeedProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: seedColor)),
      initialRoute: '/',
      routes: {
        '/': (context) => MainApp(title: 'Gulu Water'),
        '/${GuRoutes.ADD_RECORD_PAGE}': (context) => AddRecordPage(),
        '/${GuRoutes.PRIVACY_PAGE}': (context) => PrivacyPage(),
        '/${GuRoutes.TARGET_SETTING_PAGE}': (context) => TargetSettingPage(),
        '/${GuRoutes.THEME_SETTING_PAGE}': (context) => ThemeSettingPage(),
      },
    );
  }
}
