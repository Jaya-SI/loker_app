import 'package:flutter/material.dart';
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
            labelColor: Color(0xff4F4F4F),
            unselectedLabelColor: Color(0xffBDBDBD),
            tabs: [
              Tab(text: "Seleksi"),
              Tab(text: "Hasil Seleksi"),
              Tab(text: "Interview"),
              Tab(text: "Hasil Interview"),
            ],
          ),
        ),
        body: BlocBuilder<NotifikasiBloc, NotifikasiState>(
          builder: (context, state) {
            if (state is NotifikasiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NotifikasiLoadAll) {
              var data = state.notifikasiHrd.data!.map((e) => state
                  .notifikasiHrd.data!
                  .where((element) => element!.status == 'Lolos Seleksi')
                  .toList());
              lolosCount = data.map((e) => e.length).toList()[0];

              var dataSeleksi = state.notifikasiHrd.data!.map((e) => state
                  .notifikasiHrd.data!
                  .where((element) => element!.status == 'Seleksi')
                  .toList());
              seleksiCount = dataSeleksi.map((e) => e.length).toList()[0];

              var dataDitolak = state.notifikasiHrd.data!.map((e) => state
                  .notifikasiHrd.data!
                  .where((element) => element!.status == 'Ditolak')
                  .toList());
              ditolakCount = dataDitolak.map((e) => e.length).toList()[0];

              var dataInterview = state.notifikasiInterview.data!.map((e) =>
                  state.notifikasiInterview.data!
                      .where((element) => element!.status == 'Interview')
                      .toList());
              interviewCount = dataInterview.map((e) => e.length).toList()[0];

              var dataDiterima = state.notifikasiInterview.data!.map((e) =>
                  state.notifikasiInterview.data!
                      .where((element) => element!.status == 'Diterima')
                      .toList());
              diterimaCount = dataDiterima.map((e) => e.length).toList()[0];

              var dataDitolakInterview = state.notifikasiInterview.data!.map(
                  (e) => state.notifikasiInterview.data!
                      .where((element) => element!.status == 'Ditolak')
                      .toList());
              ditolakInterviewCount =
                  dataDitolakInterview.map((e) => e.length).toList()[0];
              return TabBarView(
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
              );
            }
            if (state is NotifikasiError) {
              return const Center(
                child: Text('Gagal memuat notifikasi'),
              );
            }
            return const Center(
              child: Text('Gagal memuat notifikasi'),
            );
          },
        ),
      ),
    );
  }

  Widget _seleksiPage(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'Seleksi'
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
                  date: notifikasi.data![index]!.createdAt.toString(),
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.idLoker!.nama,
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
                            Text(
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
                            Text(
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
        return notifikasi.data![index]!.status == 'Lolos Seleksi'
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
                  date: notifikasi.data![index]!.createdAt.toString(),
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.idLoker!.nama,
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
        return notifikasi.data![index]!.status == 'Ditolak'
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
                  date: notifikasi.data![index]!.createdAt.toString(),
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.idLoker!.nama,
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
        return notifikasi.data![index]!.status == 'Interview'
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
                  date: notifikasi.data![index]!.jadwal,
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.status,
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
                            Text(
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
                            Text(
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
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'Diterima'
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
                  date: notifikasi.data![index]!.jadwal,
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.status,
                ),
              )
            : Container();
      },
    );
  }

  Widget _ditolakInterview(ListInterviewModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'Ditolak'
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
                  date: notifikasi.data![index]!.jadwal,
                  nama: notifikasi.data![index]!.idPelamar!.nama,
                  status: notifikasi.data![index]!.status,
                ),
              )
            : Container();
      },
    );
  }
}
