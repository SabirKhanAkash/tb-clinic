import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:tb_clinic/core/services/log_service.dart';
import 'package:tb_clinic/data/repositories/remote/auth_repository.dart';
import 'package:tb_clinic/ui/auth/login_screen.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/config/env.dart';
import 'package:tb_clinic/viewmodels/cubit/auth/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/cubit/home/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Log.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: Env().envType == AppText().devEnv,
        title: AppText().title,
        theme: ThemeData(
          fontFamily: AppStyle().primaryFont,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor().primary),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
