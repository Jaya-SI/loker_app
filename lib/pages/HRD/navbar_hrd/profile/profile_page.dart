import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/pages/splash/splash.dart';
import 'package:loker/routes/router.gr.dart';
import 'package:loker/widgets/card_profile_widget.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../bloc/navbar/navbar_bloc.dart';
import '../../../../services/shared_preferences_services.dart';
import '../../../../widgets/header_profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String _namaUser =
        SharedPreferencesService.getAuthModel()!.user!.nama ?? '';
    String _imgUser =
        SharedPreferencesService.getAuthModel()!.user!.imgHrd ?? '';
    String _role = SharedPreferencesService.getAuthModel()!.user!.role ?? '';
    String _email = SharedPreferencesService.getAuthModel()!.user!.email ?? '';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xff4F4F4F),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderProfileCard(
                email: _email,
                namaUser: _namaUser,
                role: _role,
                image: _imgUser,
              ),
              const SizedBox(height: 30),
              CardProfile(
                onTapCheck: () async {
                  await SharedPreferencesService.clearAllPrefs();
                  context.router.replace(const SplashRoute());
                  Restart.restartApp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
