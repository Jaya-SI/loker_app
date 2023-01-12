import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/model/get_data_category_model.dart';
import 'package:loker/model/get_loker_model.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:loker/services/shared_preferences_services.dart';
import 'package:loker/widgets/btn_danger_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/category_model.dart';
import '../../../../widgets/btn_success_widget.dart';
import '../../../../widgets/text_container_widget.dart';

class DetailLokerPage extends StatefulWidget {
  const DetailLokerPage({super.key, this.dataGetLoker, this.dataCategory});
  final DataGetLoker? dataGetLoker;
  final List<GetDateCategoryModel>? dataCategory;
  @override
  State<DetailLokerPage> createState() => _DetailLokerPageState();
}

class _DetailLokerPageState extends State<DetailLokerPage> {
  GetDateCategoryModel? categoryTerpilih;
  String? idCategory;
  TextEditingController namaLoker = TextEditingController();
  TextEditingController gaji = TextEditingController();
  TextEditingController deskripsi1 = TextEditingController();
  TextEditingController deskripsi2 = TextEditingController();
  TextEditingController deskripsi3 = TextEditingController();
  TextEditingController alamat = TextEditingController();

  File? _image;
  String? img64Foto;
  dynamic bytes;

  List<dynamic> statusDropdown = ['Open', 'Close'];
  String statusTerlpilih = 'Open';

  @override
  void initState() {
    namaLoker.text = widget.dataGetLoker!.nama!;
    gaji.text = widget.dataGetLoker!.gaji!;
    deskripsi1.text = widget.dataGetLoker!.deskripsi1!;
    deskripsi2.text = widget.dataGetLoker!.deskripsi2!;
    deskripsi3.text = widget.dataGetLoker!.deskripsi3!;
    alamat.text = widget.dataGetLoker!.alamat!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
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
          'Detail Loker',
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Gambar Loker",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff272C2F),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 160,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 10],
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: Center(
                      child: widget.dataGetLoker!.imgLoker != null
                          ? InkWell(
                              onTap: () {
                                addImage();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        (widget.dataGetLoker!.imgLoker!),
                                        fit: BoxFit.cover,
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
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: namaLoker,
                maxLines: 1,
                title: "Nama Loker",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: gaji,
                maxLines: 1,
                title: "Gaji",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: alamat,
                maxLines: 1,
                title: "Alamat",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: deskripsi1,
                maxLines: 3,
                title: "Deskripsi 1",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: deskripsi2,
                maxLines: 3,
                title: "Deskripsi 2",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextContainerWidget(
                controller: deskripsi3,
                maxLines: 3,
                title: "Deskripsi 3",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Text(
                "Status",
                style: GoogleFonts.poppins(
                  color: const Color(0xff272C2F),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffC5C5C5), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 15),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration.collapsed(hintText: ''),
                      hint: Text(widget.dataGetLoker!.status!),
                      items: <String>['open', 'close'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        setState(() {
                          statusTerlpilih = _!;
                        });
                      },
                    ),
                  ),
                ),
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
                child: DropdownSearch<GetDateCategoryModel>(
                  showSearchBox: true,
                  dropdownSearchDecoration:
                      const InputDecoration.collapsed(hintText: ''),
                  maxHeight: 230,
                  items: widget.dataCategory,
                  hint: widget.dataGetLoker!.idCategory!.namaCategory,
                  selectedItem: categoryTerpilih,
                  itemAsString: (item) => item!.namaCategory!,
                  onChanged: (v) {
                    categoryTerpilih = v!;
                    setState(() {
                      idCategory = categoryTerpilih!.id.toString();
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: BtnDangerWidget(
                      txtBtn: "Delete",
                      heightBtn: 8,
                      ontap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Hapus Loker"),
                            content: const Text(
                                "Apakah anda yakin ingin menghapus loker ini?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Tidak"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<LokerBloc>()
                                      .add(LokerDeleteEvent(
                                        idLoker:
                                            widget.dataGetLoker!.id.toString(),
                                      ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NavbarHRDPage(),
                                      ));
                                },
                                child: const Text("Ya"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BtnSuccessWidget(
                      heightBtn: 8,
                      txtBtn: isLoading != false ? "Loading" : "Update",
                      ontap: () {
                        isLoading = true;
                        context.read<LokerBloc>().add(LokerUpdateEvent(
                              idHrd: SharedPreferencesService.getAuthModel()!
                                  .user!
                                  .id
                                  .toString(),
                              alamat: alamat.text,
                              imgLoker: img64Foto != null ? img64Foto : null,
                              tanggal: DateTime.now().toString(),
                              status: statusTerlpilih,
                              idLoker: widget.dataGetLoker!.id.toString(),
                              nama: namaLoker.text,
                              gaji: gaji.text,
                              deskripsi1: deskripsi1.text,
                              deskripsi2: deskripsi2.text,
                              deskripsi3: deskripsi3.text,
                              idCategory: idCategory != null
                                  ? categoryTerpilih!.id.toString()
                                  : widget.dataGetLoker!.idCategory!.id
                                      .toString(),
                            ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavbarHRDPage(),
                            ));
                      },
                    ),
                  ),
                ],
              )
            ],
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
}
