import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/model/get_data_category_model.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, this.category});
  final GetDateCategoryModel? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: 30.w,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE1EDF2).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 15), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Container
          //   width: 10.w,
          //   height: 7.h,
          //   child: Image.asset(
          //     'assets/icons/category_mobile.png',
          //   ),
          // ),
          Container(
            width: 10.w,
            height: 6.h,
            child: Image.network(
              category?.imgCategory ?? '',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Text(
                category?.namaCategory ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 9.sp,
                  color: const Color(0xff272C2F),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
