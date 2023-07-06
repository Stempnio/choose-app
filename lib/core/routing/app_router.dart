import 'package:auto_route/auto_route.dart';
import 'package:choose_app/presentation/pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        _splashRoute,
      ];
}

final _splashRoute = AutoRoute(
  page: SplashRoute.page,
  initial: true,
);
