import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HeaderWellcomeWidget extends StatelessWidget {
  const HeaderWellcomeWidget(
      {super.key, this.name, this.image, this.imgNetwork});
  final String? name;
  final String? image;
  final String? imgNetwork;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang",
                  style: GoogleFonts.poppins(
                    color: const Color(0xffB3B5C4),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  name ?? "",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff272C2F),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(4),
            height: 15.h,
            width: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imgNetwork != null
                    ? Image.network('$imgNetwork').image
                    : AssetImage(image!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
