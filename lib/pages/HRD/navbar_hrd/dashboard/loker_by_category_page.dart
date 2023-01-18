import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loker/model/get_data_category_model.dart';
import 'package:loker/pages/HRD/navbar_hrd/navbar_hrd.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/loker/loker_bloc.dart';
import '../../../../widgets/loker_post_widget.dart';
import 'detail_loker_dashboard.dart';

class LokerByCategoryPage extends StatelessWidget {
  const LokerByCategoryPage({super.key, this.idCategory, this.categoryModel});
  final int? idCategory;
  final GetDateCategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LokerBloc>(context)
        .add(GetLokerByIdCategoryEvent(idCategory: idCategory.toString()));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavbarHRDPage(),
                  ));
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Color(0xff272C2F),
            )),
        title: Text(
          categoryModel!.namaCategory.toString(),
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
            BlocProvider.of<LokerBloc>(context).add(
                GetLokerByIdCategoryEvent(idCategory: idCategory.toString()));
          } else if (state is LokerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LokerGetLoaded) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: ListView.builder(
                itemCount: state.getLokerModel.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailLokerDashboardPage(
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
          return Container();
        },
      ),
    );
  }
}
