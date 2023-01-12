// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../pages/HRD/login/login_hrd_page.dart' as _i5;
import '../pages/HRD/navbar_hrd/navbar_hrd.dart' as _i6;
import '../pages/Pelamar/Login/login_pelamar_page.dart' as _i3;
import '../pages/Pelamar/Login/register_pelamar_page.dart' as _i4;
import '../pages/Pelamar/Navbar/navbar_pelamar.dart' as _i7;
import '../pages/splash/splash.dart' as _i1;
import '../pages/splash/splash_login_page.dart' as _i2;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SplashLoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SplashLoginPage(),
      );
    },
    LoginPelamarRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPelamarPage(),
      );
    },
    RegisterPelamarRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPelamarPage(),
      );
    },
    LoginHRDRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.LoginHRDPage(),
      );
    },
    NavbarHRDRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NavbarHRDPage(),
      );
    },
    NavbarPelamarRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.NavbarPelamarPage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          SplashLoginRoute.name,
          path: '/splash-login-page',
        ),
        _i8.RouteConfig(
          LoginPelamarRoute.name,
          path: '/login-pelamar-page',
        ),
        _i8.RouteConfig(
          RegisterPelamarRoute.name,
          path: '/register-pelamar-page',
        ),
        _i8.RouteConfig(
          LoginHRDRoute.name,
          path: '/login-hr-dPage',
        ),
        _i8.RouteConfig(
          NavbarHRDRoute.name,
          path: '/navbar-hr-dPage',
        ),
        _i8.RouteConfig(
          NavbarPelamarRoute.name,
          path: '/navbar-pelamar-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SplashLoginPage]
class SplashLoginRoute extends _i8.PageRouteInfo<void> {
  const SplashLoginRoute()
      : super(
          SplashLoginRoute.name,
          path: '/splash-login-page',
        );

  static const String name = 'SplashLoginRoute';
}

/// generated route for
/// [_i3.LoginPelamarPage]
class LoginPelamarRoute extends _i8.PageRouteInfo<void> {
  const LoginPelamarRoute()
      : super(
          LoginPelamarRoute.name,
          path: '/login-pelamar-page',
        );

  static const String name = 'LoginPelamarRoute';
}

/// generated route for
/// [_i4.RegisterPelamarPage]
class RegisterPelamarRoute extends _i8.PageRouteInfo<void> {
  const RegisterPelamarRoute()
      : super(
          RegisterPelamarRoute.name,
          path: '/register-pelamar-page',
        );

  static const String name = 'RegisterPelamarRoute';
}

/// generated route for
/// [_i5.LoginHRDPage]
class LoginHRDRoute extends _i8.PageRouteInfo<void> {
  const LoginHRDRoute()
      : super(
          LoginHRDRoute.name,
          path: '/login-hr-dPage',
        );

  static const String name = 'LoginHRDRoute';
}

/// generated route for
/// [_i6.NavbarHRDPage]
class NavbarHRDRoute extends _i8.PageRouteInfo<void> {
  const NavbarHRDRoute()
      : super(
          NavbarHRDRoute.name,
          path: '/navbar-hr-dPage',
        );

  static const String name = 'NavbarHRDRoute';
}

/// generated route for
/// [_i7.NavbarPelamarPage]
class NavbarPelamarRoute extends _i8.PageRouteInfo<void> {
  const NavbarPelamarRoute()
      : super(
          NavbarPelamarRoute.name,
          path: '/navbar-pelamar-page',
        );

  static const String name = 'NavbarPelamarRoute';
}
