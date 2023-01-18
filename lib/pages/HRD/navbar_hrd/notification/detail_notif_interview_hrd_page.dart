import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/interview/interview_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/list_interview_model.dart';
import '../navbar_hrd.dart';

class DetailNotifInterviewHrdPage extends StatelessWidget {
  DetailNotifInterviewHrdPage({this.data, super.key});
  Datum? data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewBloc, InterviewState>(
      builder: (context, state) {
        if (state is InterviewLoaded) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text(state.interview.status!),
              ),
            );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => NavbarHRDPage(),
            //     ));
          });
        }

        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Color(0xff272C2F),
                ),
              ),
              title: Text(
                'Detail Interview',
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
            body: BlocBuilder<InterviewBloc, InterviewState>(
              builder: (context, state) {
                if (state is InterviewLoaded) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        content: Text(state.interview.status!),
                      ),
                    );
                  });
                }
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 28.w,
                          width: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: data!.idPelamar!.imgPelamar != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        data!.idPelamar!.imgPelamar!),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/jaya.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          data!.idPelamar!.nama ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Surat Lamaran ",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xffC5C5C5),
                          ),
                        ),
                        child: Text(
                          data!.idSeleksi!.suratLamaran ?? "",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00AFB9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _launchUrl,
                          child: Text(
                            "Download CV",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Jadwal Interview",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xffC5C5C5),
                          ),
                        ),
                        child: Text(
                          data!.jadwal ?? "",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff00AFB9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<InterviewBloc>(context).add(
                                    UpdateInterviewEvent(
                                      idHrd: data!.idHrd!.id.toString(),
                                      idPelamar: data!.idPelamar!.id.toString(),
                                      idSeleksi: data!.idSeleksi!.id.toString(),
                                      jadwal: data!.jadwal ?? "",
                                      token: data!.token ?? "",
                                      status: "Diterima",
                                    ),
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NavbarHRDPage(),
                                      ));
                                },
                                child: Text(
                                  "Lolos Interview",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFD4F56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<InterviewBloc>(context).add(
                                    UpdateInterviewEvent(
                                      idHrd: data!.idHrd!.id.toString(),
                                      idPelamar: data!.idPelamar!.id.toString(),
                                      idSeleksi: data!.idSeleksi!.id.toString(),
                                      jadwal: data!.jadwal ?? "",
                                      token: data!.token ?? "",
                                      status: "Ditolak",
                                    ),
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NavbarHRDPage(),
                                      ));
                                },
                                child: Text(
                                  "Tolak",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse(data!.idPelamar!.cv!),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch url';
    }
  }
}
