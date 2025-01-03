import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tb_clinic/ui/home/components/build_app_bar.dart';
import 'package:tb_clinic/ui/home/components/build_home_body.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/viewmodels/home/home_cubit.dart';
import 'package:tb_clinic/viewmodels/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterSecureStorage? secureStorage;
  String? dp = "", userName = "Md. Shabir Khan Akash";

  @override
  void initState() {
    secureStorage = const FlutterSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, dp, userName),
      body: buildHomeBody(context),
      bottomNavigationBar: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // if (state is BottomNavBarItemSelection) {
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(SnackBar(content: Text("Successfully Item Selected")));
          // }
        },
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return BottomNavigationBar(
            elevation: 65,
            showSelectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: state is BottomNavBarItemSelection
                    ? state.currentItemIndex == 0
                        ? SvgPicture.asset(AppImage().homeIconSelected)
                        : SvgPicture.asset(AppImage().homeIcon)
                    : SvgPicture.asset(AppImage().homeIconSelected),
                label: AppText().homeLabel,
                tooltip: AppText().homeLabel,
              ),
              BottomNavigationBarItem(
                icon: state is BottomNavBarItemSelection
                    ? state.currentItemIndex == 1
                        ? SvgPicture.asset(AppImage().locationIconSelected)
                        : SvgPicture.asset(AppImage().locationIcon)
                    : SvgPicture.asset(AppImage().locationIcon),
                label: AppText().locationLabel,
                tooltip: AppText().locationLabel,
              ),
              BottomNavigationBarItem(
                icon: state is BottomNavBarItemSelection
                    ? state.currentItemIndex == 2
                        ? SvgPicture.asset(AppImage().chatIconSelected)
                        : SvgPicture.asset(AppImage().chatIcon)
                    : SvgPicture.asset(AppImage().chatIcon),
                label: AppText().chatLabel,
                tooltip: AppText().chatLabel,
              ),
              BottomNavigationBarItem(
                icon: state is BottomNavBarItemSelection
                    ? state.currentItemIndex == 3
                        ? SvgPicture.asset(AppImage().profileIconSelected)
                        : SvgPicture.asset(AppImage().profileIcon)
                    : SvgPicture.asset(AppImage().profileIcon),
                label: AppText().profileLabel,
                tooltip: AppText().profileLabel,
              ),
            ],
            onTap: cubit.selectBottomNavItem,
            currentIndex: (state is BottomNavBarItemSelection) ? state.currentItemIndex : 0,
            // onTap: ,
          );
        },
      ),
    );
  }
}
