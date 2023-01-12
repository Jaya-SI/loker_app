import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/pages/Pelamar/Login/register_pelamar_page.dart';
import 'package:loker/pages/Pelamar/Navbar/navbar_pelamar.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../widgets/btn_primary_widget.dart';
import '../../../widgets/btn_txt_widget.dart';
import '../../../widgets/custom_textfield.dart';

class LoginPelamarPage extends StatelessWidget {
  const LoginPelamarPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
          }
          if (state is AuthSuccessPelamar) {
            return const NavbarPelamarPage();
          }
          if (state is AuthFailed) {
            isLoading = false;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: Text(state.message),
                ),
              );
            });
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              color: Color(0xffB3B5C4),
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            'With Your Account',
                            style: GoogleFonts.poppins(
                              color: Color(0xff272C2F),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(child: Image.asset('assets/images/splash.png')),
                    CustomTextField(
                      controller: emailController,
                      isObsecure: false,
                      title: 'Email',
                      hintText: '',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      isObsecure: true,
                      title: 'Password',
                      hintText: '',
                    ),
                    const SizedBox(height: 40),
                    BtnPrimaryWidget(
                      isLoading: isLoading,
                      heightBtn: 55,
                      widthBtn: MediaQuery.of(context).size.width,
                      txtBtn: 'Sign In',
                      ontap: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          BlocProvider.of<AuthBloc>(context).add(
                              LoginAuthPelamarEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Email dan Password tidak boleh kosong'),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: BtnTxtWidget(
                        txtBtn: 'Register',
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPelamarPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
