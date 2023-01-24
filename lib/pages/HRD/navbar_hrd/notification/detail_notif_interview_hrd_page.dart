import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/interview/interview_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/list_interview_model.dart';
import '../navbar_hrd.dart';

class DetailNotifInterviewHrdPage extends StatefulWidget {
  DetailNotifInterviewHrdPage({this.data, super.key});
  Datum? data;

  @override
  State<DetailNotifInterviewHrdPage> createState() =>
      _DetailNotifInterviewHrdPageState();
}

class _DetailNotifInterviewHrdPageState
    extends State<DetailNotifInterviewHrdPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  image: widget.data!.idPelamar!.imgPelamar != null
                      ? DecorationImage(
                          image:
                              NetworkImage(widget.data!.idPelamar!.imgPelamar!),
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
                widget.data!.idPelamar!.nama ?? "",
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: Text(
                widget.data!.idSeleksi!.suratLamaran ?? "",
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
              "Nama Loker",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: Text(
                widget.data!.idLoker!.nama ?? "",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Gaji",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: Text(
                widget.data!.idLoker!.gaji ?? "",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: Text(
                widget.data!.jadwal ?? "",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Keterangan Interview",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: Text(
                widget.data!.keterangan ?? "",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            widget.data!.status == "Diterima"
                ? Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff00AFB9),
                    ),
                    child: Center(
                      child: Text(
                        "Peserta Lolos Interview",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Row(
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
                                  id: widget.data!.id.toString(),
                                  idHrd: widget.data!.idHrd!.id.toString(),
                                  idPelamar:
                                      widget.data!.idPelamar!.id.toString(),
                                  idSeleksi:
                                      widget.data!.idSeleksi!.id.toString(),
                                  jadwal: widget.data!.jadwal ?? "",
                                  token: widget.data!.token ?? "",
                                  status: "Diterima",
                                  namaLoker: widget.data!.idLoker!.nama ?? "",
                                  idLoker: widget.data!.idLoker!.id.toString(),
                                  keterangan: widget.data!.keterangan ?? "-",
                                ),
                              );
                              setState(() {
                                isLoading = true;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavbarHRDPage(),
                                  ));
                            },
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
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
                                  keterangan: widget.data!.keterangan ?? "-",
                                  id: widget.data!.id.toString(),
                                  idHrd: widget.data!.idHrd!.id.toString(),
                                  idPelamar:
                                      widget.data!.idPelamar!.id.toString(),
                                  idSeleksi:
                                      widget.data!.idSeleksi!.id.toString(),
                                  jadwal: widget.data!.jadwal ?? "",
                                  token: widget.data!.token ?? "",
                                  status: "Ditolak",
                                  namaLoker: widget.data!.idLoker!.nama ?? "",
                                  idLoker: widget.data!.idLoker!.id.toString(),
                                ),
                              );
                              setState(() {
                                isLoading = true;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavbarHRDPage(),
                                  ));
                            },
                            child: isLoading
                                ? CircularProgressIndicator()
                                : Text(
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
      ),
      // body: BlocBuilder<InterviewBloc, InterviewState>(
      //   builder: (context, state) {
      //     if (state is InterviewLoaded) {
      //       SchedulerBinding.instance.addPostFrameCallback((_) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             duration: const Duration(milliseconds: 500),
      //             content: Text(state.interview.status!),
      //           ),
      //         );
      //       });
      //     }
      //     return SingleChildScrollView(
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Center(
      //             child: Container(
      //               height: 28.w,
      //               width: 28.w,
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 color: Colors.white,
      //                 image: data!.idPelamar!.imgPelamar != null
      //                     ? DecorationImage(
      //                         image: NetworkImage(data!.idPelamar!.imgPelamar!),
      //                         fit: BoxFit.cover,
      //                       )
      //                     : const DecorationImage(
      //                         image: AssetImage(
      //                           "assets/images/jaya.png",
      //                         ),
      //                         fit: BoxFit.cover,
      //                       ),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Center(
      //             child: Text(
      //               data!.idPelamar!.nama ?? "",
      //               style: GoogleFonts.poppins(
      //                 fontSize: 20.sp,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //               textAlign: TextAlign.center,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Text(
      //             "Surat Lamaran ",
      //             style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               border: Border.all(
      //                 color: const Color(0xffC5C5C5),
      //               ),
      //             ),
      //             child: Text(
      //               data!.idSeleksi!.suratLamaran ?? "",
      //               style: GoogleFonts.poppins(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 30),
      //           Container(
      //             height: 55,
      //             width: MediaQuery.of(context).size.width,
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: const Color(0xff00AFB9),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //               ),
      //               onPressed: _launchUrl,
      //               child: Text(
      //                 "Download CV",
      //                 style: GoogleFonts.poppins(),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Text(
      //             "Jadwal Interview",
      //             style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               border: Border.all(
      //                 color: const Color(0xffC5C5C5),
      //               ),
      //             ),
      //             child: Text(
      //               data!.jadwal ?? "",
      //               style: GoogleFonts.poppins(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Text(
      //             "Keterangan Interview",
      //             style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               border: Border.all(
      //                 color: const Color(0xffC5C5C5),
      //               ),
      //             ),
      //             child: Text(
      //               data!.keterangan ?? "",
      //               style: GoogleFonts.poppins(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 30),
      //           data!.status == "Diterima"
      //               ? Container(
      //                   height: 55,
      //                   padding: const EdgeInsets.symmetric(vertical: 10),
      //                   width: MediaQuery.of(context).size.width,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(5),
      //                     color: const Color(0xff00AFB9),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       "Peserta Lolos Interview",
      //                       style: GoogleFonts.poppins(
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.w500,
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               : Row(
      //                   children: [
      //                     Expanded(
      //                       child: Container(
      //                         height: 55,
      //                         width: MediaQuery.of(context).size.width,
      //                         child: ElevatedButton(
      //                           style: ElevatedButton.styleFrom(
      //                             backgroundColor: const Color(0xff00AFB9),
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(8),
      //                             ),
      //                           ),
      //                           onPressed: () {
      //                             BlocProvider.of<InterviewBloc>(context).add(
      //                               UpdateInterviewEvent(
      //                                 id: data!.id.toString(),
      //                                 idHrd: data!.idHrd!.id.toString(),
      //                                 idPelamar: data!.idPelamar!.id.toString(),
      //                                 idSeleksi: data!.idSeleksi!.id.toString(),
      //                                 jadwal: data!.jadwal ?? "",
      //                                 token: data!.token ?? "",
      //                                 status: "Diterima",
      //                               ),
      //                             );
      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                   builder: (context) => NavbarHRDPage(),
      //                                 ));
      //                           },
      //                           child: Text(
      //                             "Lolos Interview",
      //                             style: GoogleFonts.poppins(),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(width: 10),
      //                     Expanded(
      //                       child: Container(
      //                         height: 55,
      //                         width: MediaQuery.of(context).size.width,
      //                         child: ElevatedButton(
      //                           style: ElevatedButton.styleFrom(
      //                             backgroundColor: const Color(0xffFD4F56),
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(8),
      //                             ),
      //                           ),
      //                           onPressed: () {
      //                             BlocProvider.of<InterviewBloc>(context).add(
      //                               UpdateInterviewEvent(
      //                                 id: data!.id.toString(),
      //                                 idHrd: data!.idHrd!.id.toString(),
      //                                 idPelamar: data!.idPelamar!.id.toString(),
      //                                 idSeleksi: data!.idSeleksi!.id.toString(),
      //                                 jadwal: data!.jadwal ?? "",
      //                                 token: data!.token ?? "",
      //                                 status: "Ditolak",
      //                               ),
      //                             );
      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                   builder: (context) => NavbarHRDPage(),
      //                                 ));
      //                           },
      //                           child: Text(
      //                             "Tolak",
      //                             style: GoogleFonts.poppins(),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse(widget.data!.idPelamar!.cv!),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch url';
    }
  }
}
