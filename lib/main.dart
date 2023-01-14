import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loker/bloc/auth/auth_bloc.dart';
import 'package:loker/bloc/category/category_bloc.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/bloc/navbar/navbar_bloc.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/repositories/auth/auth_repository.dart';
import 'package:loker/repositories/category/category_repository.dart';
import 'package:loker/repositories/loker/loker_repository.dart';
import 'package:loker/repositories/notifikasi/notifikasi_repository.dart';
import 'package:loker/repositories/seleksi/seleksi_repository.dart';
import 'package:loker/routes/router.gr.dart';
import 'package:loker/services/shared_preferences_services.dart';
import 'package:sizer/sizer.dart';

import 'bloc/seleksi/seleksi_bloc.dart';
import 'bloc/splash/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(SplashToHome())),
        BlocProvider<NavbarBloc>(create: (context) => NavbarBloc()),
        BlocProvider(
          create: (context) => AuthBloc(Authrepository()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRepository()),
        ),
        BlocProvider(
          create: (context) => LokerBloc(LokerRepository()),
        ),
        BlocProvider(
          create: (context) => NotifikasiBloc(NotifikasiRepository()),
        ),
        BlocProvider(
          create: (context) => SeleksiBloc(SeleksiRepository()),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
            // home: const SplashPage(),
          );
        },
      ),
    );
  }
}
