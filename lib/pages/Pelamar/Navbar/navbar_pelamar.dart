import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/pages/Pelamar/Navbar/dashboard/dashboard_pelamar.dart';
import 'package:loker/pages/Pelamar/Navbar/notifikasi/notifikasi_pelamar.dart';
import 'package:loker/pages/Pelamar/Navbar/profile/profile_pelamar.dart';
import 'package:loker/pages/Pelamar/Navbar/whislist/whislist_page.dart';

import '../../../bloc/category/category_bloc.dart';
import '../../../bloc/loker/loker_bloc.dart';
import '../../../bloc/navbar/navbar_bloc.dart';
import '../../../services/shared_preferences_services.dart';

class NavbarPelamarPage extends StatelessWidget {
  const NavbarPelamarPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
    BlocProvider.of<LokerBloc>(context).add(GetLokerDashboardEvent());
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              context.read<NavbarBloc>().add(NavbarChanged(value));
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/icons/dashboard.png',
                    width: 24,
                    color: state is NavbarLoaded && state.index == 0
                        ? const Color(0xff272C2F)
                        : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/icons/notification.png',
                    width: 24,
                    color: state is NavbarLoaded && state.index == 1
                        ? const Color(0xff272C2F)
                        : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/icons/add_loker.png',
                    width: 24,
                    color: state is NavbarLoaded && state.index == 2
                        ? const Color(0xff272C2F)
                        : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/icons/person.png',
                    width: 24,
                    color: state is NavbarLoaded && state.index == 3
                        ? const Color(0xff272C2F)
                        : Colors.grey,
                  ),
                ),
                label: '',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.amber[800],
          ),
          body: state is NavbarInitial
              ? const DashBoardPelamarPage()
              : body(context, state),
        );
      },
    );
  }

  Widget body(BuildContext context, state) {
    if (state.index == 0) {
      BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
      BlocProvider.of<LokerBloc>(context).add(GetLokerDashboardEvent());
      return const DashBoardPelamarPage();
    }
    if (state.index == 1) {
      BlocProvider.of<NotifikasiBloc>(context).add(GetNotifikasiEvent(
          id: SharedPreferencesService.getAuthPelamarModel()!
              .pelamar!
              .id
              .toString()));
      return const NotifikasiPelamarPage();
    }
    if (state.index == 2) {
      return const WhislistPage();
    }
    if (state.index == 3) {
      return const ProfilePelamarPage();
    }
    return state;
  }
}
