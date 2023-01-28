import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/counter.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/detail_lolos_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/detail_notif_interview_hrd_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/detail_notif_seleksi_page.dart';
import 'package:loker/widgets/notification_card_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/hrd_list_notifikasi_model.dart';
import '../../../../model/list_interview_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  CounterPage counter = CounterPage();

  CounterInterview counterInterview = CounterInterview();

  List<int> _idPelamar = [];
  int lolosCount = 0;
  int ditolakCount = 0;
  int interviewCount = 0;
  int seleksiCount = 0;
  int diterimaCount = 0;
  int ditolakInterviewCount = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotifikasiBloc>(context).add(GetNotifikasiAllEvent());
    HrdGetListNotifikasiModel notifikasi = HrdGetListNotifikasiModel();
    ListInterviewModel interview = ListInterviewModel();

    return BlocBuilder<NotifikasiBloc, NotifikasiState>(
      builder: (context, state) {
        if (state is NotifikasiLoading) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Notification',
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
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is NotifikasiLoadAll) {
          var dataSeleksi = state.notifikasiHrd.data!.map((e) => state
              .notifikasiHrd.data!
              .where((element) => element.status == 'Seleksi')
              .toList());
          seleksiCount = dataSeleksi.length > 0
              ? dataSeleksi.map((e) => e.length).toList()[0]
              : 0;

          var data = state.notifikasiHrd.data!.map((e) => state
              .notifikasiHrd.data!
              .where((element) => element.status == 'Lolos Seleksi')
              .toList());
          lolosCount =
              data.length > 0 ? data.map((e) => e.length).toList()[0] : 0;

          var dataDitolak = state.notifikasiHrd.data!.map((e) => state
              .notifikasiHrd.data!
              .where((element) => element.status == 'Ditolak')
              .toList());
          ditolakCount = dataDitolak.length > 0
              ? dataDitolak.map((e) => e.length).toList()[0]
              : 0;

          var dataInterview = state.notifikasiInterview.data!.map((e) => state
              .notifikasiInterview.data!
              .where((element) => element.status == 'Interview')
              .toList());

          interviewCount = dataInterview.length > 0
              ? dataInterview.map((e) => e.length).toList()[0]
              : 0;

          var dataDiterima = state.notifikasiInterview.data!.map((e) => state
              .notifikasiInterview.data!
              .where((element) => element.status == 'Diterima')
              .toList());
          diterimaCount = dataDiterima.length > 0
              ? dataDiterima.map((e) => e.length).toList()[0]
              : 0;

          var ditolakInterview = state.notifikasiInterview.data!.map((e) =>
              state.notifikasiInterview.data!
                  .where((element) => element.status == 'Ditolak')
                  .toList());
          ditolakInterviewCount = ditolakInterview.length > 0
              ? ditolakInterview.map((e) => e.length).toList()[0]
              : 0;

          return DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Notification',
                    style: GoogleFonts.poppins(
                      color: const Color(0xff4F4F4F),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    labelColor: const Color(0xff4F4F4F),
                    unselectedLabelColor: const Color(0xffBDBDBD),
                    tabs: [
                      Tab(text: "Seleksi $seleksiCount"),
                      const Tab(text: "Hasil Seleksi"),
                      Tab(text: "Interview $interviewCount"),
                      const Tab(text: "Hasil Interview"),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _seleksiPage(
                      state.notifikasiHrd,
                    ),
                    _hasilSeleksiPage(
                      state.notifikasiHrd,
                    ),
                    _interviewPage(
                      state.notifikasiInterview,
                    ),
                    _hasilInterviewPage(
                      state.notifikasiInterview,
                    ),
                  ],
                )),
          );
        }
        return Container();
      },
    );
  }

  Widget _seleksiPage(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index].status == 'Seleksi'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotifSeleksiPage(
                            data: notifikasi.data![index]),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].createdAt.toString(),
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].idLoker!.nama,
                ),
              )
            : Container();
      },
    );
  }

  Widget _hasilSeleksiPage(HrdGetListNotifikasiModel notifikasi) {
    return BlocBuilder<CounterPage, int>(
      bloc: counter,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        counter.backPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: state == 0
                                ? const BorderSide(
                                    color: Color(0xff4F4F4F), width: 2)
                                : const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Ditolak",
                              textAlign: TextAlign.center,
                            ),
                            Text(ditolakCount.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        counter.nextPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: state == 1
                                ? const BorderSide(
                                    color: Color(0xff4F4F4F), width: 2)
                                : const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lolos Seleksi",
                              textAlign: TextAlign.center,
                            ),
                            Text(lolosCount.toString()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: state == 1 ? _lolos(notifikasi) : _ditolak(notifikasi))
          ],
        );
      },
    );
  }

  Widget _lolos(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index].status == 'Lolos Seleksi'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailLolosPage(data: notifikasi.data![index]),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].createdAt.toString(),
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].idLoker!.nama,
                ),
              )
            : Container();
      },
    );
  }

  Widget _ditolak(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index].status == 'Ditolak'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotifSeleksiPage(
                            data: notifikasi.data![index]),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].createdAt.toString(),
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].idLoker!.nama,
                ),
              )
            : Container();
      },
    );
  }

  Widget _interviewPage(ListInterviewModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index].status == 'Interview'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotifInterviewHrdPage(
                          data: notifikasi.data![index],
                        ),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].jadwal,
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].status,
                ),
              )
            : Container();
      },
    );
  }

  Widget _hasilInterviewPage(ListInterviewModel notifikasi) {
    return BlocBuilder<CounterInterview, int>(
      bloc: counterInterview,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        counterInterview.backPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: state == 0
                                ? const BorderSide(
                                    color: Color(0xff4F4F4F), width: 2)
                                : const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Ditolak",
                              textAlign: TextAlign.center,
                            ),
                            Text(ditolakInterviewCount.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        counterInterview.nextPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: state == 1
                                ? const BorderSide(
                                    color: Color(0xff4F4F4F), width: 2)
                                : const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Diterima",
                              textAlign: TextAlign.center,
                            ),
                            Text(diterimaCount.toString()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: state == 1
                  ? _lolosInterview(notifikasi)
                  : _ditolakInterview(notifikasi),
            )
          ],
        );
      },
    );
  }

  Widget _lolosInterview(ListInterviewModel notifikasi) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: notifikasi.data!.length,
          itemBuilder: (context, index) {
            return notifikasi.data![index].status == 'Diterima'
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailNotifInterviewHrdPage(
                              data: notifikasi.data![index],
                            ),
                          ));
                    },
                    child: NotificationCardWidget(
                      date: notifikasi.data![index].jadwal,
                      nama: notifikasi.data![index].idPelamar!.nama,
                      status: notifikasi.data![index].status,
                    ),
                  )
                : Container();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: const Icon(Icons.print),
              onPressed: () async {
                await Printing.layoutPdf(
                    onLayout: (format) =>
                        _generatePdf(format, 'title', notifikasi));
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, String title, ListInterviewModel notifikasi) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      (await rootBundle.load('assets/images/twincom.png')).buffer.asUint8List(),
    );

    List<pw.Widget> list = [];

    for (var i = 0; i < notifikasi.data!.length; i++) {
      if (notifikasi.data![i].status == 'Diterima') {
        list.add(
          pw.Container(
            color: PdfColors.white,
            padding: const pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(1),
                1: const pw.FlexColumnWidth(4),
                2: const pw.FlexColumnWidth(4),
                3: const pw.FlexColumnWidth(4),
              },
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child:
                          pw.Text("${i + 1}", textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Text(
                          notifikasi.data![i].idPelamar!.nama.toString(),
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Text(
                          notifikasi.data![i].idLoker!.nama.toString(),
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Text(notifikasi.data![i].status.toString(),
                          textAlign: pw.TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 20),
                child: pw.Center(
                  child: pw.Image(image, height: 70),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Divider(color: PdfColors.black),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Center(
                  child: pw.Text(
                    "Laporan Calon Karyawan Yang dinyatakan Diterima",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Divider(color: PdfColors.black),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 20),
                child: pw.Column(
                  children: list,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // pdf.addPage(
    //   pw.MultiPage(
    //     pageFormat: format,
    //     build: (pw.Context context) => <pw.Widget>[
    //       pw.Column(
    //         children: [
    //           pw.Container(
    //             padding: const pw.EdgeInsets.symmetric(vertical: 20),
    //             child: pw.Center(
    //               child: pw.Image(image, height: 70),
    //             ),
    //           ),
    //           pw.Padding(
    //             padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //             child: pw.Divider(color: PdfColors.black),
    //           ),
    //           pw.Container(
    //             margin: const pw.EdgeInsets.symmetric(vertical: 20),
    //             child: pw.Center(
    //               child: pw.Text(
    //                 "Laporan Calon Karyawan Yang dinyatakan Diterima",
    //                 style: pw.TextStyle(
    //                     fontWeight: pw.FontWeight.bold, fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           pw.Container(
    //             color: PdfColors.white,
    //             padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //             child: pw.Table(
    //               columnWidths: {
    //                 0: const pw.FlexColumnWidth(1),
    //                 1: const pw.FlexColumnWidth(4),
    //                 2: const pw.FlexColumnWidth(4),
    //                 3: const pw.FlexColumnWidth(4),
    //               },
    //               border: pw.TableBorder.all(color: PdfColors.black),
    //               children: [
    //                 pw.TableRow(
    //                   children: [
    //                     pw.Padding(
    //                       padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //                       child: pw.Text('NO', textAlign: pw.TextAlign.center),
    //                     ),
    //                     pw.Padding(
    //                       padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //                       child:
    //                           pw.Text('Nama', textAlign: pw.TextAlign.center),
    //                     ),
    //                     pw.Padding(
    //                       padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //                       child: pw.Text('Lamaran',
    //                           textAlign: pw.TextAlign.center),
    //                     ),
    //                     pw.Padding(
    //                       padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //                       child:
    //                           pw.Text('Status', textAlign: pw.TextAlign.center),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           pw.ListView.builder(
    //             itemCount: notifikasi.data!.length,
    //             itemBuilder: (context, index) {
    //               return pw.Container(
    //                 color: PdfColors.white,
    //                 padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //                 child: pw.Table(
    //                   columnWidths: {
    //                     0: const pw.FlexColumnWidth(1),
    //                     1: const pw.FlexColumnWidth(4),
    //                     2: const pw.FlexColumnWidth(4),
    //                     3: const pw.FlexColumnWidth(4),
    //                   },
    //                   border: pw.TableBorder.all(color: PdfColors.black),
    //                   children: [
    //                     pw.TableRow(
    //                       children: [
    //                         pw.Padding(
    //                           padding:
    //                               const pw.EdgeInsets.symmetric(vertical: 5),
    //                           child: pw.Text("${index + 1}",
    //                               textAlign: pw.TextAlign.center),
    //                         ),
    //                         pw.Padding(
    //                           padding:
    //                               const pw.EdgeInsets.symmetric(vertical: 5),
    //                           child: pw.Text(
    //                               notifikasi.data![index].idPelamar!.nama
    //                                   .toString(),
    //                               textAlign: pw.TextAlign.center),
    //                         ),
    //                         pw.Padding(
    //                           padding:
    //                               const pw.EdgeInsets.symmetric(vertical: 5),
    //                           child: pw.Text(
    //                               notifikasi.data![index].idLoker!.nama
    //                                   .toString(),
    //                               textAlign: pw.TextAlign.center),
    //                         ),
    //                         pw.Padding(
    //                           padding:
    //                               const pw.EdgeInsets.symmetric(vertical: 5),
    //                           child: pw.Text(
    //                               notifikasi.data![index].status.toString(),
    //                               textAlign: pw.TextAlign.center),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ],
    //       )
    //     ],
    //   ),

    //   // pw.Page(
    //   //   pageFormat: format,
    //   //   build: (context) {
    //   //     return pw.Column(
    //   //       children: [
    //   //         pw.Container(
    //   //           padding: const pw.EdgeInsets.symmetric(vertical: 20),
    //   //           child: pw.Center(
    //   //             child: pw.Image(image, height: 70),
    //   //           ),
    //   //         ),
    //   //         pw.Padding(
    //   //           padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //   //           child: pw.Divider(color: PdfColors.black),
    //   //         ),
    //   //         pw.Container(
    //   //           margin: const pw.EdgeInsets.symmetric(vertical: 20),
    //   //           child: pw.Center(
    //   //             child: pw.Text(
    //   //               "Laporan Calon Karyawan Yang dinyatakan Diterima",
    //   //               style: pw.TextStyle(
    //   //                   fontWeight: pw.FontWeight.bold, fontSize: 16),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //         pw.Container(
    //   //           color: PdfColors.white,
    //   //           padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //   //           child: pw.Table(
    //   //             columnWidths: {
    //   //               0: const pw.FlexColumnWidth(1),
    //   //               1: const pw.FlexColumnWidth(4),
    //   //               2: const pw.FlexColumnWidth(4),
    //   //               3: const pw.FlexColumnWidth(4),
    //   //             },
    //   //             border: pw.TableBorder.all(color: PdfColors.black),
    //   //             children: [
    //   //               pw.TableRow(
    //   //                 children: [
    //   //                   pw.Padding(
    //   //                     padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                     child: pw.Text('NO', textAlign: pw.TextAlign.center),
    //   //                   ),
    //   //                   pw.Padding(
    //   //                     padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                     child:
    //   //                         pw.Text('Nama', textAlign: pw.TextAlign.center),
    //   //                   ),
    //   //                   pw.Padding(
    //   //                     padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                     child: pw.Text('Lamaran',
    //   //                         textAlign: pw.TextAlign.center),
    //   //                   ),
    //   //                   pw.Padding(
    //   //                     padding: const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                     child:
    //   //                         pw.Text('Status', textAlign: pw.TextAlign.center),
    //   //                   ),
    //   //                 ],
    //   //               ),
    //   //             ],
    //   //           ),
    //   //         ),
    //   //         pw.ListView.builder(
    //   //           itemCount: notifikasi.data!.length,
    //   //           itemBuilder: (context, index) {
    //   //             return pw.Container(
    //   //               color: PdfColors.white,
    //   //               padding: const pw.EdgeInsets.symmetric(horizontal: 20),
    //   //               child: pw.Table(
    //   //                 columnWidths: {
    //   //                   0: const pw.FlexColumnWidth(1),
    //   //                   1: const pw.FlexColumnWidth(4),
    //   //                   2: const pw.FlexColumnWidth(4),
    //   //                   3: const pw.FlexColumnWidth(4),
    //   //                 },
    //   //                 border: pw.TableBorder.all(color: PdfColors.black),
    //   //                 children: [
    //   //                   pw.TableRow(
    //   //                     children: [
    //   //                       pw.Padding(
    //   //                         padding:
    //   //                             const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                         child: pw.Text("${index + 1}",
    //   //                             textAlign: pw.TextAlign.center),
    //   //                       ),
    //   //                       pw.Padding(
    //   //                         padding:
    //   //                             const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                         child: pw.Text(
    //   //                             notifikasi.data![index].idPelamar!.nama
    //   //                                 .toString(),
    //   //                             textAlign: pw.TextAlign.center),
    //   //                       ),
    //   //                       pw.Padding(
    //   //                         padding:
    //   //                             const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                         child: pw.Text(
    //   //                             notifikasi.data![index].idLoker!.nama
    //   //                                 .toString(),
    //   //                             textAlign: pw.TextAlign.center),
    //   //                       ),
    //   //                       pw.Padding(
    //   //                         padding:
    //   //                             const pw.EdgeInsets.symmetric(vertical: 5),
    //   //                         child: pw.Text(
    //   //                             notifikasi.data![index].status.toString(),
    //   //                             textAlign: pw.TextAlign.center),
    //   //                       ),
    //   //                     ],
    //   //                   ),
    //   //                 ],
    //   //               ),
    //   //             );
    //   //           },
    //   //         )
    //   //       ],
    //   //     );
    //   //   },
    //   // ),
    // );

    return pdf.save();
  }

  Widget _ditolakInterview(ListInterviewModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index].status == 'Ditolak'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotifInterviewHrdPage(
                          data: notifikasi.data![index],
                        ),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].jadwal,
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].status,
                ),
              )
            : Container();
      },
    );
  }
}
