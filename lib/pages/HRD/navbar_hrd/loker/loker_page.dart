import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/loker/add_loker_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/loker/detail_loker_page.dart';
import 'package:loker/widgets/loker_post_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/category/category_bloc.dart';
import '../../../../model/get_data_category_model.dart';

class LokerPage extends StatelessWidget {
  const LokerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<GetDateCategoryModel> _listCategory = [];
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
        }
        if (state is CategoryGetSuccess) {
          _listCategory = state.category!;
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Loker',
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
              if (state is LokerInitial) {
                BlocProvider.of<LokerBloc>(context).add(GetLokerEvent());
              } else if (state is LokerLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LokerGetLoaded) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: ListView.builder(
                    itemCount: state.getLokerModel.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailLokerPage(
                                  dataCategory: _listCategory,
                                  dataGetLoker:
                                      state.getLokerModel.data![index]),
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
              return Container();
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff00AFB9),
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLokerPage(),
                  ));
            },
          ),
        );
      },
    );
  }
}
