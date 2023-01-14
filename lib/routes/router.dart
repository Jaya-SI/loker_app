import 'package:auto_route/auto_route.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/detail_lolos_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/detail_notif_seleksi_page.dart';
import 'package:loker/pages/Pelamar/Navbar/navbar_pelamar.dart';

import '../pages/HRD/login/login_hrd_page.dart';
import '../pages/HRD/navbar_hrd/navbar_hrd.dart';
import '../pages/Pelamar/Login/login_pelamar_page.dart';
import '../pages/Pelamar/Login/register_pelamar_page.dart';
import '../pages/splash/splash.dart';
import '../pages/splash/splash_login_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SplashLoginPage),
    AutoRoute(page: LoginPelamarPage),
    AutoRoute(page: RegisterPelamarPage),
    AutoRoute(page: LoginHRDPage),
    AutoRoute(page: NavbarHRDPage),
    AutoRoute(page: NavbarPelamarPage),
    AutoRoute(page: DetailNotifSeleksiPage),
    AutoRoute(page: DetailLolosPage),
  ],
)
class $AppRouter {}
