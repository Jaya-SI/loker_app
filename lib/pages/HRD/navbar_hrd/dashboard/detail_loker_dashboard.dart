import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/model/get_loker_model.dart';
import 'package:loker/routes/router.gr.dart';
import 'package:sizer/sizer.dart';

import '../navbar_hrd.dart';

class DetailLokerDashboardPage extends StatelessWidget {
  const DetailLokerDashboardPage({super.key, this.loker});
  final DataGetLoker? loker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              context.router.push(const NavbarHRDRoute());
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Color(0xff272C2F),
            )),
        title: Text(
          'Detail Loker',
          style: GoogleFonts.poppins(
            color: const Color(0xff4F4F4F),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: headerLoker(
                  context,
                  imgLoker: loker!.imgLoker,
                  namaLoker: loker!.nama,
                  namaCategory: loker!.idCategory!.namaCategory,
                  tahun: loker!.createdAt.toString(),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Gaji",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xff272C2F),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              textLoker(loker!.gaji),
              const SizedBox(height: 20),
              Text(
                "Deskripsi",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xff272C2F),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              textLoker(loker!.deskripsi1),
              const SizedBox(height: 20),
              textLoker(loker!.deskripsi2),
              const SizedBox(height: 20),
              textLoker(loker!.deskripsi3),
            ],
          ),
        ),
      ),
    );
  }

  Widget textLoker(String? text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff2A327D), width: 2),
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff2A327D),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text!,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: const Color(0xff272C2F),
            ),
          ),
        ),
      ],
    );
  }

  Widget headerLoker(BuildContext context,
      {String? imgLoker,
      String? namaLoker,
      String? namaCategory,
      String? tahun}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            imgLoker!,
            width: MediaQuery.of(context).size.width,
            height: 40.w,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              namaLoker!,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: const Color(0xff272C2F),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${namaCategory} • ${tahun}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: const Color(0xffB3B5C4),
              ),
            ),
          ],
        )
      ],
    );
  }
}
