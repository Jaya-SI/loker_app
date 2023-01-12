import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loker/bloc/category/category_bloc.dart';
import 'package:loker/bloc/navbar/navbar_bloc.dart';
import 'package:loker/pages/HRD/navbar_hrd/dashboard/dashboard_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/loker/loker_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/notification/notification_page.dart';
import 'package:loker/pages/HRD/navbar_hrd/profile/profile_page.dart';
import 'package:loker/pages/splash/splash.dart';

import '../../../bloc/loker/loker_bloc.dart';
import '../../../bloc/notifikasi/notifikasi_bloc.dart';

class NavbarHRDPage extends StatelessWidget {
  const NavbarHRDPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LokerBloc>(context).add(GetLokerEvent());
    BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
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
              ? const DashboardPage()
              : body(context, state),
        );
      },
    );
  }

  Widget body(BuildContext context, state) {
    if (state.index == 0) {
      BlocProvider.of<LokerBloc>(context).add(GetLokerDashboardEvent());
      BlocProvider.of<CategoryBloc>(context).add(CategoryGetEvent());
      return const DashboardPage();
    }
    if (state.index == 1) {
      BlocProvider.of<NotifikasiBloc>(context).add(HrdGetListNotifikasiEvent());
      return const NotificationPage();
    }
    if (state.index == 2) {
      BlocProvider.of<LokerBloc>(context).add(GetLokerEvent());
      return const LokerPage();
    }
    if (state.index == 3) {
      return const ProfilePage();
    }
    return const DashboardPage();
  }
}
