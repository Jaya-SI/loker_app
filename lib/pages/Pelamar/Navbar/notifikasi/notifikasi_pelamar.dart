import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/pages/Pelamar/Navbar/dashboard/detail_loker_pelamar.dart';
import 'package:loker/pages/Pelamar/Navbar/notifikasi/detail_notifikasi_interview_pelamar.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/get_loker_model.dart';
import '../../../../model/list_interview_model.dart';
import '../../../../model/notifikasi_model.dart';
import '../../../../widgets/notification_card_widget.dart';
import 'detail_hasil_lamaran_pelamar.dart.dart';

class NotifikasiPelamarPage extends StatelessWidget {
  const NotifikasiPelamarPage({super.key});

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
              Tab(text: "Hasil Lamaran"),
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
            if (state is NotifikasiLoadAllPelamar) {
              return TabBarView(
                children: [
                  _seleksiPage(
                    state.notifikasi,
                  ),
                  _interviewPage(state.notifikasiInterview),
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

  Widget _seleksiPage(GetNotifikasiModel notifikasi) {
    return ListView.builder(
      itemCount: notifikasi.data!.length,
      itemBuilder: (context, index) {
        return notifikasi.data![index]!.status == 'Seleksi' ||
                notifikasi.data![index]!.status == 'Lolos Seleksi'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailLokerPelamar(
                          data: notifikasi.data![index]!,
                          idPelamar: notifikasi.data![index]!.idPelamar!.id!,
                          status: notifikasi.data![index]!.status,
                          loker: DataGetLoker(
                            id: notifikasi.data![index]!.idLoker!.id,
                            nama: notifikasi.data![index]!.idLoker!.nama,
                            alamat: notifikasi.data![index]!.idLoker!.alamat,
                            deskripsi1:
                                notifikasi.data![index]!.idLoker!.deskripsi1,
                            deskripsi2:
                                notifikasi.data![index]!.idLoker!.deskripsi2,
                            deskripsi3:
                                notifikasi.data![index]!.idLoker!.deskripsi3,
                            gaji: notifikasi.data![index]!.idLoker!.gaji,
                            imgLoker:
                                notifikasi.data![index]!.idLoker!.imgLoker,
                            status: notifikasi.data![index]!.idLoker!.status,
                            createdAt:
                                notifikasi.data![index]!.idLoker!.createdAt,
                            updatedAt:
                                notifikasi.data![index]!.idLoker!.updatedAt,
                            idCategory: IdCategory(
                              id: int.parse(notifikasi
                                  .data![index]!.idLoker!.idCategory!),
                            ),
                          ),
                        ),
                      ));
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index]!.createdAt.toString(),
                  nama: notifikasi.data![index]!.idLoker!.nama,
                  status: notifikasi.data![index]!.status,
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
                      builder: (context) => DetailNotifikasiInterviewPelamar(
                        data: notifikasi.data![index],
                      ),
                    ),
                  );
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].jadwal.toString(),
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].status,
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
        return notifikasi.data![index].status == 'Diterima' ||
                notifikasi.data![index].status == 'Ditolak'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailHasilLamaranPelamar(
                        data: notifikasi.data![index],
                      ),
                    ),
                  );
                },
                child: NotificationCardWidget(
                  date: notifikasi.data![index].jadwal.toString(),
                  nama: notifikasi.data![index].idPelamar!.nama,
                  status: notifikasi.data![index].status,
                ),
              )
            : Container();
      },
    );
  }
}
