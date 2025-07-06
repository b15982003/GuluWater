import 'package:flutter/material.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';
import 'package:gulu_water/feature/widget/bottom_navigate.dart';
import 'package:gulu_water/feature/history/history_page.dart';
import 'package:gulu_water/feature/home/home_page.dart';
import 'package:gulu_water/feature/setting/setting_page.dart';

import '../core/routes/routes.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.title});

  final String title;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _bottomSelectedIndex = 0;

  void _onNavBottomTap(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [_btnAddRecord()],
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: homeBottomNavigationBar(
        context: context,
        currentIndex: _bottomSelectedIndex,
        onTap: _onNavBottomTap,
      ),
    );
  }

  Widget _buildBody() {
    switch (_bottomSelectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const HistoryPage();
      case 2:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }

  Widget _btnAddRecord() {
    return IconButton(
      onPressed: () => _navigateAddRecordPage(context),
      icon: Icon(Icons.add, size: GuDirect.iconSize28,),
    );
  }

  void _navigateAddRecordPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.ADD_RECORD_PAGE}');
  }
}
