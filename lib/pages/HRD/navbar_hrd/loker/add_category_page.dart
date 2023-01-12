import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loker/bloc/category/category_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/btn_success_widget.dart';
import '../../../../widgets/text_container_widget.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  File? _image;
  String? img64Foto;
  dynamic bytes;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController namaCategory = TextEditingController();
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
          'Tambah Category',
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
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            isLoading = true;
          }
          if (state is CategorySuccess) {
            isLoading = false;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Category berhasil ditambahkan'),
                ),
              );
            });
            img64Foto = null;
            _image = null;
            namaCategory.clear();
          }
          if (state is CategoryFailed) {
            isLoading = false;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: Text(state.message),
                ),
              );
            });
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 10],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: Center(
                          child: _image != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      addImage();
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(_image!),
                                    ),
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    addImage();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color(0xff00AFB9),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextContainerWidget(
                    controller: namaCategory,
                    maxLines: 1,
                    title: "Nama Category",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 60),
                  BtnSuccessWidget(
                    heightBtn: 8,
                    txtBtn: isLoading ? "Loading" : "Posting Category",
                    ontap: () {
                      if (namaCategory.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Nama Category Tidak Boleh Kosong'),
                          ),
                        );
                      } else {
                        context.read<CategoryBloc>().add(CategoryAddEvent(
                            namaCategory: namaCategory.text,
                            imgCategory: img64Foto!));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
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
}
