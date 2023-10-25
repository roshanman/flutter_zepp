import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/sport/sport_page.dart';
import 'pages/sleep/sleep_page.dart';
import 'pages/mine/mine_page.dart';
import 'pages/sky/sky_page.dart';
import 'images.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

enum TabType { home, sleep, sky, sport, mine }

class _TabWidgetConfig {
  final TabType tabType;
  final Widget tabWidget;
  final String title;
  final Widget icon;
  final Widget activeIcon;

  _TabWidgetConfig({
    required this.tabType,
    required this.tabWidget,
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

class _MainTabBarState extends State<MainTabBar> {
  late final List<_TabWidgetConfig> pages;

  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      _TabWidgetConfig(
        tabType: TabType.home,
        tabWidget: const HomePage(),
        title: '首页',
        icon: Image.asset(TabbarImages.status_unselected, width: 24, height: 24),
        activeIcon: Image.asset(TabbarImages.status, width: 24, height: 24),
      ),
      _TabWidgetConfig(
        tabType: TabType.home,
        tabWidget: const SleepPage(),
        title: '睡眠',
        icon: Image.asset(TabbarImages.sleep_unselected, width: 24, height: 24),
        activeIcon: Image.asset(TabbarImages.sleep, width: 24, height: 24),
      ),
      _TabWidgetConfig(
        tabType: TabType.home,
        tabWidget: const SkyPage(),
        title: 'Aura',
        icon: Image.asset(TabbarImages.aura_unselected, width: 24, height: 24),
        activeIcon: Image.asset(TabbarImages.aura, width: 24, height: 24),
      ),
      _TabWidgetConfig(
        tabType: TabType.home,
        tabWidget: const SportPage(),
        title: '运动',
        icon: Image.asset(TabbarImages.workout_unselected, width: 24, height: 24),
        activeIcon: Image.asset(TabbarImages.workout, width: 24, height: 24),
      ),
      _TabWidgetConfig(
        tabType: TabType.home,
        tabWidget: MinePage(),
        title: '我的',
        icon: Image.asset(TabbarImages.profile_unselected, width: 24, height: 24),
        activeIcon: Image.asset(TabbarImages.profile, width: 24, height: 24),
      ),
    ];
  }

  void _changeSelectedPage(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.map((e) => e.tabWidget).toList()[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: _changeSelectedPage,
        items: pages.map((e) => BottomNavigationBarItem(icon: e.icon, activeIcon: e.activeIcon, label: e.title)).toList(),
      ),
    );
  }
}
