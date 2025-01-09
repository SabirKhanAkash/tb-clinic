import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/helpers/map_helper.dart';

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
        final locationResult = await MapHelper().getMyLocation();
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
      future: MapHelper().getRoute(tbClinicLatLng),
      builder: (context, snapshot) {
        List<LatLng> routePoints = [];
        if (snapshot.hasData) routePoints = snapshot.data!;
        var myAddress;
        final bounds = LatLngBounds.fromPoints(
          routePoints.isNotEmpty
              ? routePoints
              : [
                  myLatLng ?? LatLng(AppText().defaultLatitude, AppText().defaultLongitude),
                  tbClinicLatLng
                ],
        );
        MapHelper().getMyAddress().then((addressEither) {
          addressEither.fold(
            (errorMessage) => myAddress = errorMessage,
            (address) => myAddress = address,
          );
        });

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: FlutterMap(
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
                          strokeWidth: 5,
                        ),
                      ],
                    ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        rotate: true,
                        point: myLatLng ??
                            LatLng(AppText().defaultLatitude, AppText().defaultLongitude),
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
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: AppColor().white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppText().locationHeading,
                          style: TextStyle(
                            color: AppColor().black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppStyle().veryLargeDp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppText().locationSubHeading,
                          style: TextStyle(
                            color: AppColor().smallGray,
                            fontWeight: FontWeight.normal,
                            fontSize: AppStyle().regularDp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          myAddress,
                          style: TextStyle(
                            color: AppColor().smallGray,
                            fontWeight: FontWeight.normal,
                            fontSize: AppStyle().regularDp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
