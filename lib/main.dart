import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/routes.dart';
import 'core/theme/GuDirect.dart';
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
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: GuDirect.waterBlue),
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => MainApp(title: 'Gulu Water'),
          '/${GuRoutes.ADD_RECORD_PAGE}':(context) => AddRecordPage(),
        },
      ),
    );
  }
}
