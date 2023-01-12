import 'package:flutter/material.dart';

class SharedCode {
  final BuildContext context;

  SharedCode(this.context);

  //shared preferences constants
  static const String authJson = 'authJson';
  static const String authJsonPelamar = 'authJsonPelamar';

  //Api constants
  static const String baseUrl = 'https://lokerpkl.banjarcode.com';
}
