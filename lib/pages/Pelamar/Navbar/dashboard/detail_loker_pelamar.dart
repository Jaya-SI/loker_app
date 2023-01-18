import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/model/notifikasi_model.dart';
import 'package:loker/pages/Pelamar/Navbar/navbar_pelamar.dart';
import 'package:loker/repositories/loker/loker_repository.dart';
import 'package:loker/widgets/btn_danger_widget.dart';
import 'package:loker/widgets/btn_primary_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/get_loker_model.dart';
import '../../../../widgets/text_container_widget.dart';

class DetailLokerPelamar extends StatelessWidget {
  const DetailLokerPelamar(
      {super.key, this.loker, required this.idPelamar, this.status, this.data});
  final DataGetLoker? loker;
  final Datum? data;
  final int idPelamar;
  final String? status;

  @override
  Widget build(BuildContext context) {
    print(data!.status);
    String? _idSeleksi;
    BlocProvider.of<LokerBloc>(context).add(
      CheckRegisteredLokerEvent(
        idLoker: loker!.id.toString(),
        idPelamar: idPelamar.toString(),
      ),
    );
    TextEditingController suratController = TextEditingController();
    bool isLoading = false;
    bool isRegistered = false;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavbarPelamarPage(),
                  ));
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
        child: BlocBuilder<LokerBloc, LokerState>(
          builder: (context, state) {
            if (state is LokerLoading) {
              isLoading = true;
            }
            if (state is SeleksiLoaded) {
              isLoading = false;
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('Berhasil Apply Loker'),
                  ),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavbarPelamarPage(),
                    ));
              });
            }
            if (state is LokerError) {
              isLoading = false;
            }
            return SingleChildScrollView(
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
                      status: status,
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
                  const SizedBox(height: 20),
                  TextContainerWidget(
                    controller: suratController,
                    maxLines: 4,
                    title: "Surat Lamaran (Opsional)",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 40),
                  data!.status == "Lolos Seleksi"
                      ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff01C488),
                            ),
                            child: Center(
                              child: Text(
                                "Lolos Seleksi",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: BlocBuilder<LokerBloc, LokerState>(
                            builder: (context, state) {
                              if (state is LokerLoading) {
                                return const CircularProgressIndicator();
                              }
                              if (state is CheckLokerLoaded) {
                                _idSeleksi =
                                    state.checkLokerModel.data!.id.toString();
                                isRegistered = true;
                              }
                              if (isRegistered != true) {
                                return BtnPrimaryWidget(
                                  ontap: () {
                                    BlocProvider.of<LokerBloc>(context).add(
                                      AddLokertoSeleksiEvent(
                                        idPelamar: idPelamar.toString(),
                                        idLoker: loker!.id.toString(),
                                        suratLamaran: suratController.text != ""
                                            ? suratController.text
                                            : "",
                                      ),
                                    );
                                  },
                                  isLoading: isLoading,
                                  heightBtn: 12.w,
                                  widthBtn:
                                      MediaQuery.of(context).size.width * 0.50,
                                  txtBtn: isLoading ? "" : "Apply Loker",
                                );
                              } else {
                                return BtnDangerWidget(
                                  // isLoading: isLoading,
                                  heightBtn: 5,
                                  widthBtn:
                                      MediaQuery.of(context).size.width * 0.50,
                                  txtBtn: "Cancel",
                                  ontap: () async {
                                    final res = await LokerRepository()
                                        .deleteSeleksi(id: _idSeleksi);
                                    if (res == "200") {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NavbarPelamarPage(),
                                          ),
                                          (route) => false);
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        )
                ],
              ),
            );
          },
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
      String? tahun,
      String? status}) {
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
            status != null
                ? Text(
                    status,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: const Color(0xffB3B5C4),
                    ),
                  )
                : Text(
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
