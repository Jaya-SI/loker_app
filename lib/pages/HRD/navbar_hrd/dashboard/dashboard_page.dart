import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/category/category_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/dashboard/detail_loker_dashboard.dart';
import 'package:loker/pages/HRD/navbar_hrd/dashboard/loker_by_category_page.dart';
import 'package:loker/services/shared_preferences_services.dart';
import 'package:loker/widgets/category_card.dart';
import 'package:loker/widgets/header_wellcome.dart';
import 'package:loker/widgets/loker_post_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/loker/loker_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
    // BlocProvider.of<LokerBloc>(context).add(GetLokerDashboardEvent());
    String _namaUser =
        SharedPreferencesService.getAuthModel()!.user!.nama ?? '';

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
                      // if (state is CategoryInitial) {
                      //   BlocProvider.of<CategoryBloc>(context)
                      //       .add(CategoryGetEvent());
                      // }
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
                                      builder: (context) => LokerByCategoryPage(
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
                    // if (state is LokerInitial) {
                    //   BlocProvider.of<LokerBloc>(context)
                    //       .add(GetLokerDashboardEvent());
                    // }
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
                                    builder: (context) =>
                                        DetailLokerDashboardPage(
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
