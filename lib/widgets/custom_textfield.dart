import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.isObsecure,
  });
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final bool? isObsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: GoogleFonts.poppins(
              color: const Color(0xffB3B5C4),
              fontSize: 10.sp,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 10.h,
            child: TextField(
              obscureText: isObsecure!,
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xffF1F0F5),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xffB3B5C4),
                  fontSize: 12.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xffB3B5C4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
