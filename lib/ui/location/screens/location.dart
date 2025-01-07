import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/helpers/helpers.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  LatLng? myLatLng;
  LatLng? tbClinicLatLng = LatLng(AppText().tbClinicLatitude, AppText().tbClinicLongitude);

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        final locationResult = await Helpers().getMyLocation();
        locationResult.fold(
          (ifLeft) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ifLeft))),
          (ifRight) => myLatLng = ifRight,
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myLatLng != tbClinicLatLng
        ? FlutterMap(
            options: MapOptions(
              initialCenter: myLatLng ?? const LatLng(0.0, 0.0),
              initialZoom: 20,
            ),
            children: [
              TileLayer(
                urlTemplate: AppText().openStreetMapUrlTemplate,
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    rotate: true,
                    point: myLatLng ?? const LatLng(0.0, 0.0),
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      AppImage().patientNavIndicator,
                    ),
                  ),
                  Marker(
                    rotate: true,
                    point: tbClinicLatLng ?? const LatLng(0.0, 0.0),
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      AppImage().tbClinicNavIndicator,
                    ),
                  ),
                ],
              ),
            ],
          )
        : FlutterMap(
            options: MapOptions(
              initialCenter: myLatLng ?? const LatLng(0.0, 0.0),
              initialZoom: 20,
            ),
            children: [
              TileLayer(
                urlTemplate: AppText().openStreetMapUrlTemplate,
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    rotate: true,
                    point: myLatLng ?? const LatLng(0.0, 0.0),
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      AppImage().patientNavIndicator,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
