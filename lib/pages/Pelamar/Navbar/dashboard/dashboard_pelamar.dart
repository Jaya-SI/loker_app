import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/category/category_bloc.dart';
import '../../../../bloc/loker/loker_bloc.dart';
import '../../../../services/shared_preferences_services.dart';
import '../../../../widgets/category_card.dart';
import '../../../../widgets/header_wellcome.dart';
import '../../../../widgets/loker_post_widget.dart';
import 'detail_loker_pelamar.dart';
import 'loker_by_category_pelamar.dart';

class DashBoardPelamarPage extends StatelessWidget {
  const DashBoardPelamarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
    // BlocProvider.of<LokerBloc>(context).add(GetLokerDashboardEvent());
    String _namaUser =
        SharedPreferencesService.getAuthPelamarModel()!.pelamar!.nama ?? '';
    String _imgUser =
        SharedPreferencesService.getAuthPelamarModel()!.pelamar!.imgPelamar ??
            '';
    int? _idPelamar =
        SharedPreferencesService.getAuthPelamarModel()!.pelamar!.id;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWellcomeWidget(
                  name: _namaUser,
                  image: "assets/images/jaya.png",
                  imgNetwork: _imgUser,
                ),
                const SizedBox(height: 40),
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: const Color(0xff272C2F),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 140,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitial) {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(CategoryGetEvent());
                      }
                      if (state is CategoryGetSuccess) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.category!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LokerByCategoryPelamarPage(
                                        idPelamar: _idPelamar,
                                        categoryModel: state.category![index],
                                        idCategory: state.category![index].id,
                                      ),
                                    ));
                              },
                              child: CategoryCard(
                                category: state.category![index],
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Just Posted',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: const Color(0xff272C2F),
                  ),
                ),
                const SizedBox(height: 25),
                BlocBuilder<LokerBloc, LokerState>(
                  builder: (context, state) {
                    if (state is LokerInitial) {
                      BlocProvider.of<LokerBloc>(context)
                          .add(GetLokerDashboardEvent());
                    }
                    if (state is LokerGetLoaded) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.getLokerModel.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailLokerPelamar(
                                      idPelamar: _idPelamar!,
                                      loker: state.getLokerModel.data![index],
                                    ),
                                  ),
                                );
                              },
                              child: LokerPostWidget(
                                dataGetLoker: state.getLokerModel.data![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
