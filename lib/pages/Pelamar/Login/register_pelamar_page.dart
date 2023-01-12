import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:loker/pages/Pelamar/Login/login_pelamar_page.dart';
import 'package:loker/repositories/auth/auth_repository.dart';
import 'package:sizer/sizer.dart';

import '../../../model/pelamar_model.dart';
import '../../../services/shared_preferences_services.dart';
import '../../../widgets/btn_primary_widget.dart';
import '../../../widgets/btn_txt_widget.dart';
import '../../../widgets/custom_textfield.dart';

class RegisterPelamarPage extends StatefulWidget {
  const RegisterPelamarPage({super.key});

  @override
  State<RegisterPelamarPage> createState() => _RegisterPelamarPageState();
}

class _RegisterPelamarPageState extends State<RegisterPelamarPage> {
  bool isLoading = false;
  String? jenisKelamin;
  String? fileCVName;
  File? fileCV;

  File? _image;
  String? img64Foto;
  dynamic bytes;

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          color: const Color(0xffB3B5C4),
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        'Create New Account',
                        style: GoogleFonts.poppins(
                          color: const Color(0xff272C2F),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                    child: InkWell(
                  onTap: () {
                    addImage();
                  },
                  child: _image != null
                      ? Container(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/upload_photo.png',
                          width: 135,
                        ),
                )),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: namaController,
                  isObsecure: false,
                  title: 'Nama',
                  hintText: '',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: alamatController,
                  isObsecure: false,
                  title: 'Alamat',
                  hintText: '',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: noHpController,
                  isObsecure: false,
                  title: 'No HP',
                  hintText: '',
                ),
                const SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Kelamin",
                        style: GoogleFonts.poppins(
                          color: const Color(0xffB3B5C4),
                          fontSize: 10.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xffF1F0F5),
                        ),
                        height: 8.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                                filled: true,
                                fillColor: Color(0xffF1F0F5),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    'Laki-laki',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff272C2F),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  value: 'Laki-laki',
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    'Perempuan',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff272C2F),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  value: 'Perempuan',
                                ),
                              ],
                              onChanged: ((value) {
                                setState(() {
                                  jenisKelamin = value.toString();
                                });
                              }),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CV",
                        style: GoogleFonts.poppins(
                          color: const Color(0xffB3B5C4),
                          fontSize: 10.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xffF1F0F5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                fileCVName ?? "",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff272C2F),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                getPDF();
                              },
                              icon: const Icon(Icons.file_upload),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  isObsecure: false,
                  title: 'Email',
                  hintText: '',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  isObsecure: true,
                  title: 'Password',
                  hintText: '',
                ),
                const SizedBox(height: 40),
                BtnPrimaryWidget(
                  isLoading: isLoading,
                  heightBtn: 55,
                  widthBtn: MediaQuery.of(context).size.width,
                  txtBtn: isLoading ? 'Loading...' : 'Daftar',
                  ontap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    RegisterPelamarModel register = await Authrepository()
                        .registerPelamar(
                            cv: fileCV!,
                            fotoPelamar: img64Foto!,
                            namaPelamar: namaController.text,
                            emailPelamar: emailController.text,
                            passwordPelamar: passwordController.text,
                            noHpPelamar: noHpController.text,
                            alamatPelamar: alamatController.text,
                            jenisKelaminPelamar: jenisKelamin!);
                    if (register.success == true) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPelamarPage(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(register.message.toString()),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(register.message.toString()),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: BtnTxtWidget(
                    txtBtn: 'Login',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPelamarPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addImage() async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked = File(
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50))!
            .path);
    CroppedFile? file = await ImageCropper().cropImage(
      sourcePath: imagePicked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    setState(() {
      _image = File(file!.path);
      bytes = File(file.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      img64Foto = img64;
    });
  }

  getPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      setState(() {
        fileCV = File(file.path!);
        fileCVName = file.name;
      });
    } else {
      // User canceled the picker
    }
  }
}
