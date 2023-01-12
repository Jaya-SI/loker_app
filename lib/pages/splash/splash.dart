import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loker/bloc/splash/splash_bloc.dart';
import 'package:loker/model/pelamar_model.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:loker/pages/splash/splash_login_page.dart';

import '../../model/auth_model.dart';
import '../../services/shared_preferences_services.dart';
import '../Pelamar/Navbar/navbar_pelamar.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashLoaded) {
            AuthModel? auth = SharedPreferencesService.getAuthModel();
            AuthPelamarModel? authPelamar =
                SharedPreferencesService.getAuthPelamarModel();
            if (auth != null) {
              return const NavbarHRDPage();
            } else if (authPelamar != null) {
              print(authPelamar.pelamar!.nama);
              return const NavbarPelamarPage();
            }
            return const SplashLoginPage();
          }
          return Center(
            child: Image.asset('assets/images/splash.png'),
          );
        },
      ),
    );
  }
}
