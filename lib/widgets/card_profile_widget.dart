import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../bloc/navbar/navbar_bloc.dart';

class CardProfile extends StatelessWidget {
  CardProfile({this.onTapCheck, super.key});
  final Function? onTapCheck;

  int _messageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.read<NavbarBloc>().add(NavbarChanged(0));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/dashboard.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Dashboard",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<NavbarBloc>().add(NavbarChanged(1));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/notification.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Notifikasi",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            sendPushMessage();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/add_loker.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Loker",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onTapCheck!.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                  width: 1,
                ),
              ),
            ),
            height: 55,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/log_out.png',
                  color: const Color(0xff00AFB9),
                  width: 7.w,
                  height: 7.h,
                ),
                const SizedBox(width: 12),
                Text(
                  "Logout",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Authorization':
              'key = AAAAwU-csss:APA91bGRBpMMd5tdR4E0o-LA5Usn0YLuvygPyMI421OG6f3YI_UgM_UKqW3ovgCRTjyGOaBZfCCcCBanresDcFXVZ136eOOK5M0kWnP2Bq91pqhCRBm-mta6pwcZezdHkd5ht-Q_TpV7',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(
            "dW-C8NZYQxa3jVWqalcg3K:APA91bHQERrTGVDm-jr-94xKXLEEIbpwgh9X9DcGGWlsotasG3V9eZ-7S8yzPF4U6boyThAXRkDNxzeIln55389VRIitlGja2Mf8mLtTo6OauDWIph9NVK2d8HSvkjZd8NHIORGiKpHN"),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  String constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      "to": token,
      "notification": {
        "body": "Selamat anda diterima sebagai Frontend Developer di PT. XYZ",
        "title": "Notifikasi"
      }
    });
  }
}
