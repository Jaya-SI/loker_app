import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/common/shared_code.dart';
import 'package:loker/model/model.dart';
import 'package:loker/model/servicemodel.dart';
import 'package:loker/pages/HRD/navbar_hrd/loker/add_category_page.dart';
import 'package:loker/services/shared_preferences_services.dart';
import 'package:loker/widgets/text_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/btn_success_widget.dart';

class AddLokerPage extends StatefulWidget {
  const AddLokerPage({super.key});

  @override
  State<AddLokerPage> createState() => _AddLokerPageState();
}

class _AddLokerPageState extends State<AddLokerPage> {
  List<DropdownCategory>? listDropdownCategory;
  DropdownCategory? selectedCategory;
  String? idCategory;
  @override
  void initState() {
    fetchCategory().then((value) {
      setState(() {
        listDropdownCategory = value;
      });
    });
    super.initState();
  }

  File? _image;
  String? img64Foto;
  dynamic bytes;
  TextEditingController namaLokerController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController deskripsi1Controller = TextEditingController();
  TextEditingController deskripsi2Controller = TextEditingController();
  TextEditingController deskripsi3Controller = TextEditingController();
  TextEditingController gajicontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCategoryPage()));
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xff272C2F),
              ),
            ),
          ],
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
            'Tambah Loker',
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
        body: BlocBuilder<LokerBloc, LokerState>(
          builder: (context, state) {
            if (state is LokerLoading) {
              isloading = true;
            }
            if (state is LokerLoaded) {
              isloading = false;
              BlocProvider.of<LokerBloc>(context).add(GetLokerEvent());
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('Loker berhasil ditambahkan'),
                  ),
                );
              });
              Navigator.pop(context);
            }
            if (state is LokerError) {
              isloading = false;
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
                    Text(
                      "Gambar Loker",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff272C2F),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 160,
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
                          )),
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: namaLokerController,
                      maxLines: 1,
                      title: "Nama Loker",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: alamatController,
                      maxLines: 1,
                      title: "Alamat",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: gajicontroller,
                      maxLines: 1,
                      title: "Gaji",
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: deskripsi1Controller,
                      maxLines: 3,
                      title: "Deskripsi 1",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: deskripsi2Controller,
                      maxLines: 3,
                      title: "Deskripsi 2",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextContainerWidget(
                      controller: deskripsi3Controller,
                      maxLines: 3,
                      title: "Deskripsi 3",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Category",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff272C2F),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff272C2F),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: DropdownSearch<DropdownCategory>(
                        showSearchBox: true,
                        dropdownSearchDecoration:
                            const InputDecoration.collapsed(hintText: ''),
                        maxHeight: 230,
                        items: listDropdownCategory,
                        selectedItem: selectedCategory,
                        itemAsString: (item) => item!.nama_category.toString(),
                        onChanged: (v) {
                          selectedCategory = v!;
                          setState(() {
                            idCategory = selectedCategory!.id.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    BtnSuccessWidget(
                      heightBtn: 8,
                      txtBtn: isloading ? 'Loading...' : 'Tambahkan Loker',
                      ontap: () {
                        context.read<LokerBloc>().add(
                              LokerAddEvent(
                                  idCategory: idCategory.toString(),
                                  idHrd:
                                      SharedPreferencesService.getAuthModel()!
                                          .user!
                                          .id
                                          .toString(),
                                  nama: namaLokerController.text,
                                  imgLoker: img64Foto.toString(),
                                  alamat: alamatController.text,
                                  tanggal: DateTime.now().toString(),
                                  deskripsi1: deskripsi1Controller.text,
                                  deskripsi2: deskripsi2Controller.text,
                                  deskripsi3: deskripsi3Controller.text,
                                  gaji: gajicontroller.text,
                                  status: 'open'),
                            );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
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
