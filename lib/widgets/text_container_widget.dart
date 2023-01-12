import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextContainerWidget extends StatelessWidget {
  const TextContainerWidget(
      {super.key,
      this.maxLines,
      this.title,
      this.controller,
      required this.keyboardType});
  final int? maxLines;
  final String? title;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: GoogleFonts.poppins(
            color: const Color(0xff272C2F),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffC5C5C5),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          maxLines: maxLines,
        )
      ],
    );
  }
}
