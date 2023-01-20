import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../bloc/navbar/navbar_bloc.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({this.onTapCheck, super.key});
  final Function? onTapCheck;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.read<NavbarBloc>().add(NavbarChanged(0));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/dashboard.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Dashboard",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<NavbarBloc>().add(NavbarChanged(1));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/notification.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Notifikasi",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     context.read<NavbarBloc>().add(NavbarChanged(2));
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 15),
        //     margin: const EdgeInsets.only(bottom: 10),
        //     decoration: const BoxDecoration(
        //       border: Border(
        //         bottom: BorderSide(
        //           color: Color(0xffE5E5E5),
        //           width: 1,
        //         ),
        //       ),
        //     ),
        //     height: 55,
        //     child: Row(
        //       children: [
        //         Image.asset(
        //           'assets/icons/add_loker.png',
        //           color: const Color(0xff00AFB9),
        //           width: 7.w,
        //           height: 7.h,
        //         ),
        //         const SizedBox(width: 12),
        //         Text(
        //           "Loker",
        //           style: GoogleFonts.poppins(
        //             fontSize: 10.sp,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        InkWell(
          onTap: () {
            onTapCheck!.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/log_out.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Logout",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
