import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tb_clinic/ui/home/components/build_app_bar.dart';
import 'package:tb_clinic/ui/home/components/build_home_body.dart';
import 'package:tb_clinic/ui/location/screens/location.dart';
import 'package:tb_clinic/ui/message/screens/message.dart';
import 'package:tb_clinic/ui/profile/screens/profile.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/helpers/map_helper.dart';
import 'package:tb_clinic/utils/helpers/permission_helper.dart';
import 'package:tb_clinic/viewmodels/home/home_cubit.dart';
import 'package:tb_clinic/viewmodels/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterSecureStorage? secureStorage;
  String dp = AppImage().splashLogo, userName = "Md. Shabir Khan Akash";

  @override
  void initState() {
    secureStorage = const FlutterSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is BottomNavBarItemSelection) {
          if (state.currentItemIndex == 1) {
            await PermissionHelper.handlePermission(Permission.location);
            final locationResult = await MapHelper().getMyLocation();
            locationResult.fold(
              (ifLeft) =>
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ifLeft))),
              (ifRight) => myLatLng = ifRight,
            );
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: buildAppBar(context, dp, userName),
          body: state is BottomNavBarItemSelection
              ? state.currentItemIndex == 1
                  ? const Location()
                  : state.currentItemIndex == 2
                      ? const Message()
                      : state.currentItemIndex == 3
                          ? const Profile()
                          : buildHomeBody(context)
              : buildHomeBody(context),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColor().veryLightWhite,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 10,
                  blurRadius: 40,
                  offset: Offset(-10, -10),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: AppColor().veryLightWhite,
                elevation: 265,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
