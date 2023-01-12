import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BtnSuccessWidget extends StatelessWidget {
  final double? heightBtn;
  final double? widthBtn;
  final String txtBtn;
  final Function? ontap;

  const BtnSuccessWidget(
      {super.key,
      this.heightBtn,
      this.widthBtn,
      required this.txtBtn,
      this.ontap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightBtn!.h,
      width: widthBtn != null ? widthBtn! : MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff00AFB9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: ontap as void Function()?,
        child: Text(
          txtBtn,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
