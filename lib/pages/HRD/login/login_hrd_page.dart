import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/auth/auth_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:loker/widgets/btn_primary_widget.dart';
import 'package:loker/widgets/btn_txt_widget.dart';
import 'package:loker/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class LoginHRDPage extends StatelessWidget {
  const LoginHRDPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    bool isLoading = false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
          }
          if (state is AuthSuccess) {
            return const NavbarHRDPage();
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
                              color: const Color(0xffB3B5C4),
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            'With Your Account',
                            style: GoogleFonts.poppins(
                              color: const Color(0xff272C2F),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(child: Image.asset('assets/images/splash.png')),
                    CustomTextField(
                      isObsecure: false,
                      controller: _emailController,
                      title: 'Email',
                      hintText: '',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      isObsecure: true,
                      controller: _passwordController,
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
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          isLoading = true;
                          BlocProvider.of<AuthBloc>(context).add(LoginAuthEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content:
                                  Text('Email dan Password tidak boleh kosong'),
                            ),
                          );
                        }
                      },
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
