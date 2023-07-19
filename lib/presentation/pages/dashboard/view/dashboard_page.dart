import 'package:auto_route/auto_route.dart';
import 'package:choose_app/core/core.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      resizeToAvoidBottomInset: false,
      routes: _routes(),
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: _navBarItems(context),
        showUnselectedLabels: false,
      ),
    );
  }

  List<PageRouteInfo<dynamic>> _routes() => const [
        HomeRoute(),
        SettingsRoute(),
      ];

  List<BottomNavigationBarItem> _navBarItems(BuildContext context) => [
        BottomNavigationBarItem(
          label: context.l10n.general__home,
          icon: const Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: context.l10n.general__settings,
          icon: const Icon(Icons.settings),
        ),
      ];
}
