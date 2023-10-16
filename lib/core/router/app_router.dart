import 'package:auto_route/auto_route.dart';
import 'package:test_map/view/screen/auth/auth_page.dart';
import 'package:test_map/view/screen/auth/otp_page.dart';
import 'package:test_map/view/screen/home/map_page.dart';
import 'package:test_map/view/screen/splash/splash_page.dart';

part 'app_router.gr.dart';

final router = AppRouter();

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: OTPRoute.page),
        AutoRoute(page: MapRoute.page),
      ];
}
