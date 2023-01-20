import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/seleksi/seleksi_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/hrd_list_notifikasi_model.dart';
import '../../../../services/shared_preferences_services.dart';

class DetailLolosPage extends StatefulWidget {
  DetailLolosPage({this.data, super.key});
  Datum? data;

  @override
  State<DetailLolosPage> createState() => _DetailLolosPageState();
}

class _DetailLolosPageState extends State<DetailLolosPage> {
  TextEditingController _keterangan = TextEditingController();
  String? jadwal;
  @override
  Widget build(BuildContext context) {
    String _idHrd =
        SharedPreferencesService.getAuthModel()!.user!.id.toString();
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
          'Interview',
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
      body: BlocBuilder<SeleksiBloc, SeleksiState>(
        builder: (context, state) {
          if (state is SeleksiLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SeleksiLoadedAddInterview) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text(state.addInterview.status!),
                ),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavbarHRDPage(),
                  ));
            });
          }
          return SingleChildScrollView(
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
                              image: NetworkImage(
                                  widget.data!.idPelamar!.imgPelamar!),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xffC5C5C5),
                    ),
                  ),
                  child: Text(
                    widget.data!.suratLamaran ?? "",
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
                const SizedBox(height: 30),
                Container(
                  height: 50.w,
                  width: MediaQuery.of(context).size.width,
                  child: widget.data!.idLoker!.imgLoker != null
                      ? Image.network(
                          widget.data!.idLoker!.imgLoker!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.data!.idLoker!.nama ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff272C2F),
                        ),
                      ),
                      Text(
                        widget.data!.status ?? "",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: const Color(0xffB3B5C4),
                        ),
                      ),
                    ],
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
                textLoker(widget.data!.idLoker!.gaji ?? ""),
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
                textLoker(widget.data!.idLoker!.deskripsi1 ?? ""),
                const SizedBox(height: 20),
                textLoker(widget.data!.idLoker!.deskripsi2 ?? ""),
                const SizedBox(height: 20),
                textLoker(widget.data!.idLoker!.deskripsi3 ?? ""),
                const SizedBox(height: 30),
                Text(
                  "Feedback Seleksi",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xff272C2F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                Text(
                  "Keterangan Interview",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xff272C2F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                  controller: _keterangan,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xff272C2F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Tanggal Interview",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xff272C2F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  timePickerEntryModeInput: true,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  onChanged: (val) {
                    setState(() {
                      jadwal = val;
                    });
                  },
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
                    onPressed: () {
                      BlocProvider.of<SeleksiBloc>(context).add(
                        AddInterviewEvent(
                          idHrd: _idHrd,
                          idPelamar: widget.data!.idPelamar!.id.toString(),
                          idSeleksi: widget.data!.id.toString(),
                          jadwal: jadwal!,
                          keterangan: _keterangan.text,
                        ),
                      );
                    },
                    child: Text(
                      "Atur Jadwal Interview",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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

  //  Uri _url = Uri.parse();
  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse(widget.data!.idPelamar!.cv!),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch url';
    }
  }
}
