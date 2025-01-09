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
  LatLng tbClinicLatLng = LatLng(AppText().tbClinicLatitude, AppText().tbClinicLongitude);

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
    return FutureBuilder<List<LatLng>>(
      future: Helpers().getRoute(
        myLatLng ?? LatLng(AppText().defaultLatitude, AppText().defaultLongitude),
        tbClinicLatLng,
      ),
      builder: (context, snapshot) {
        List<LatLng> routePoints = [];
        if (snapshot.hasData) routePoints = snapshot.data!;
        print("routePoints: $routePoints");

        final bounds = LatLngBounds.fromPoints(
          routePoints.isNotEmpty
              ? routePoints
              : [
                  myLatLng ?? LatLng(AppText().defaultLatitude, AppText().defaultLongitude),
                  tbClinicLatLng
                ],
        );
        return FlutterMap(
          options: MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(50),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: AppText().openStreetMapUrlTemplate,
              subdomains: const ['a', 'b', 'c'],
            ),
            if (routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: Colors.blue,
                    strokeWidth: 3,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                Marker(
                  rotate: true,
                  point: myLatLng ?? LatLng(AppText().defaultLatitude, AppText().defaultLongitude),
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    AppImage().patientNavIndicator,
                  ),
                ),
                Marker(
                  rotate: true,
                  point: tbClinicLatLng,
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    AppImage().tbClinicNavIndicator,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
