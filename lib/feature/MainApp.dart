import 'package:flutter/material.dart';
import 'package:gulu_water/feature/widget/BottomNavigate.dart';
import 'package:gulu_water/feature/history/HistoryPage.dart';
import 'package:gulu_water/feature/home/HomePage.dart';
import 'package:gulu_water/feature/setting/SettingPage.dart';

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
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: homeBottomNavigationBar(
        context: context,
        currentIndex: _bottomSelectedIndex,
        onTap: _onNavBottomTap,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _navigateAddRecordPage(context),
        tooltip: 'Add Record',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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

  void _navigateAddRecordPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.ADD_RECORD_PAGE}');
  }
}
