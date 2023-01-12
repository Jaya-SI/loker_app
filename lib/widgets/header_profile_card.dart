import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../services/shared_preferences_services.dart';

class HeaderProfileCard extends StatelessWidget {
  HeaderProfileCard(
      {this.namaUser, this.email, this.role, this.image, super.key});
  String? namaUser;
  String? role;
  String? email;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            height: 15.h,
            width: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: image != ""
                  ? DecorationImage(
                      image: NetworkImage(image!),
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/images/jaya.png'),
                    ),
            ),
          ),
          Text(
            namaUser ?? 'Nama User',
            style: GoogleFonts.poppins(
              color: const Color(0xff4F4F4F),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            role ?? 'Role',
            style: GoogleFonts.poppins(
              color: const Color(0xff4F4F4F),
              fontSize: 10.sp,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email ?? 'Email',
            style: GoogleFonts.poppins(
              color: const Color(0xff4F4F4F),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
