import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BtnPrimaryWidget extends StatelessWidget {
  const BtnPrimaryWidget({
    super.key,
    this.txtBtn,
    this.ontap,
    this.widthBtn,
    this.heightBtn,
    this.isLoading,
  });
  final String? txtBtn;
  final Function? ontap;
  final double? widthBtn;
  final double? heightBtn;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightBtn,
      width: widthBtn,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff006130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: ontap as void Function()?,
        child: isLoading!
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                txtBtn!,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
