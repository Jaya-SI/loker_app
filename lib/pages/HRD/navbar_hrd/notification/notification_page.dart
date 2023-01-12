import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/routes/router.gr.dart';
import 'package:loker/widgets/notification_card_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/hrd_list_notifikasi_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            indicatorColor: Color(0xff006130),
            labelColor: Color(0xff4F4F4F),
            unselectedLabelColor: Color(0xffBDBDBD),
            tabs: [
              Tab(text: "Seleksi"),
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
            if (state is HrdGetNotifikasiLoaded) {
              return TabBarView(
                children: [
                  _seleksiPage(
                    state.notifikasi,
                  ),
                  _interviewPage(
                    state.notifikasi,
                  ),
                  _diterimaPage(
                    state.notifikasi,
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
        return notifikasi.data![index]!.status == 'seleksi'
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

  Widget _interviewPage(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'interview'
            ? InkWell(
                onTap: () {},
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

  Widget _diterimaPage(HrdGetListNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'diterima'
            ? InkWell(
                onTap: () {},
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
}
