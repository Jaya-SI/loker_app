import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/model/get_loker_model.dart';
import 'package:sizer/sizer.dart';

class LokerPostWidget extends StatelessWidget {
  const LokerPostWidget({this.dataGetLoker, super.key});
  final DataGetLoker? dataGetLoker;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(bottom: 25, right: 24),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              dataGetLoker!.imgLoker!,
              fit: BoxFit.cover,
              width: 45,
              height: 45,
            ),
          ),
          // Image.asset(
          //   'assets/images/google.png',
          //   width: 45,
          //   height: 45,
          // ),
          const SizedBox(width: 25),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffECEDF1),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    dataGetLoker!.nama!,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: const Color(0xff272C2F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    dataGetLoker!.idCategory!.namaCategory!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: const Color(0xffB3B5C4),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
