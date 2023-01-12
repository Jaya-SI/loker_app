import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key, this.nama, this.status, this.date});
  final String? nama;
  final String? status;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000D3A).withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: const Color(0xff4F4F4F),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: const Color(0xff4F4F4F),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              date ?? "",
              style: GoogleFonts.poppins(
                fontSize: 8.sp,
                color: const Color(0xffA3A3A3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
