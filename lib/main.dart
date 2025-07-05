import 'package:flutter/material.dart';

import 'core/routes/routes.dart';
import 'core/theme/GuColors.dart';
import 'di/SetupDbHelper.dart';
import 'feature/MainApp.dart';
import 'feature/add_record/AddRecordPage.dart';

Future<void> main() async {
  await setupDbHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: GuDirect.waterBlue),
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => MainApp(title: 'Gulu Water'),
        '/${GuRoutes.ADD_RECORD_PAGE}':(context) => AddRecordPage(),
      },
    );
  }
}
