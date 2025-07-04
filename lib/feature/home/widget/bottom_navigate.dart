import 'package:flutter/material.dart';

Widget homeBottomNavigationBar({
  required BuildContext context,
  required int currentIndex,
  required void Function(int) onTap}) {
  const navItemIcon = [
    Icon(Icons.home),
    Icon(Icons.book),
    Icon(Icons.settings),
  ];
  const navItemText = [
    Text('Home'),
    Text('History'),
    Text('Setting'),
  ];

  final bottomBar = <BottomNavigationBarItem>[];

  for (int i = 0; i < navItemIcon.length; i++) {
    bottomBar.add(
        BottomNavigationBarItem(
          icon: navItemIcon[i],
          label: navItemText[i].data,
        )
    );
  }

  return BottomNavigationBar(
    items: bottomBar,
    currentIndex: currentIndex,
    onTap: onTap,
  );
}