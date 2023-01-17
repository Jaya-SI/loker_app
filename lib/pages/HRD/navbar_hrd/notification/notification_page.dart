import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/counter.dart';
import 'package:loker/routes/router.gr.dart';
import 'package:loker/widgets/notification_card_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/hrd_list_notifikasi_model.dart';
import '../../../../model/list_interview_model.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  CounterPage counter = CounterPage();

  List<int> _idPelamar = [];

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
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xff4F4F4F),
            unselectedLabelColor: Color(0xffBDBDBD),
            tabs: [
              Tab(text: "Seleksi"),
              Tab(text: "Hasil Seleksi"),
              Tab(text: "Interview"),
              Tab(text: "Diterima"),
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
                  _diterimaPage(
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
                  context.router.push(
                    DetailNotifSeleksiRoute(
                      data: notifikasi.data![index],
                    ),
                  );
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
                        child: Text(
                          "Ditolak",
                          textAlign: TextAlign.center,
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
                        child: Text(
                          "Lolos Seleksi",
                          textAlign: TextAlign.center,
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
                  // context.router.push(
                  //   DetailNotifSeleksiRoute(
                  //     data: notifikasi.data![index],
                  //   ),
                  // );
                  context.router.push(DetailLolosRoute(
                    data: notifikasi.data![index],
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
                  context.router.push(
                    DetailNotifSeleksiRoute(
                      data: notifikasi.data![index],
                    ),
                  );
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
                onTap: () {},
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

  Widget _diterimaPage(ListInterviewModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'diterima'
            ? InkWell(
                onTap: () {},
                child: NotificationCardWidget(
                  date: notifikasi.data![index]!.createdAt.toString(),
                  nama: notifikasi.data![index]!.idSeleksi!.idPelamar,
                  status: notifikasi.data![index]!.status,
                ),
              )
            : Container();
      },
    );
  }
}
