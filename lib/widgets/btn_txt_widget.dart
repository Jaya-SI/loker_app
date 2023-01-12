import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BtnTxtWidget extends StatelessWidget {
  const BtnTxtWidget({super.key, this.txtBtn, this.ontap});
  final String? txtBtn;
  final Function? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: ontap as void Function()?,
        child: Text(
          txtBtn!,
          style: GoogleFonts.poppins(
            color: const Color(0xffB3B5C4),
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }
}
