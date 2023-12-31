import 'package:auto_route/auto_route.dart';
import 'package:choose_app/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: ChoiceInputRoute.page)
      ];
}
