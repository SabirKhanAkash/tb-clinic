import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/helpers/map_helper.dart';

class Location extends StatefulWidget {
  LatLng myLatLng;

  Location(this.myLatLng, {super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  LatLng tbClinicLatLng = LatLng(AppText().tbClinicLatitude, AppText().tbClinicLongitude);
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LatLng>>(
      future: MapHelper().getRoute(tbClinicLatLng),
      builder: (context, snapshot) {
        List<LatLng> routePoints = [];
        if (snapshot.hasData) routePoints = snapshot.data!;
        String myAddress = AppText().gettingLocationInfo;
        locationController.text = myAddress;
        final bounds = LatLngBounds.fromPoints(
          routePoints.isNotEmpty ? routePoints : [widget.myLatLng, tbClinicLatLng],
        );
        MapHelper().getMyAddress().then((addressEither) {
          addressEither.fold(
            (errorMessage) {
              locationController.text = errorMessage;
              return myAddress = errorMessage;
            },
            (address) {
              locationController.text = address;
              return myAddress = address;
            },
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
                        point: widget.myLatLng,
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
                // height: MediaQuery.of(context).size.height / 3,
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
                        child: TextField(
                          maxLines: 1,
                          onTap: () {
                            locationController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: locationController.text.length,
                            );
                          },
                          controller: locationController,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColor().smallGray,
                            fontWeight: FontWeight.normal,
                            fontSize: AppStyle().regularDp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppText().saveAsHeading,
                          style: TextStyle(
                            color: AppColor().smallGray,
                            fontWeight: FontWeight.normal,
                            fontSize: AppStyle().regularDp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.2),
                            child: Container(
                              width: (MediaQuery.of(context).size.width / 2) - 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: AppColor().veryLightWhite,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImage().homePrefix),
                                  const SizedBox(width: 8),
                                  Text(AppText().clinic),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.2),
                            child: Container(
                              width: (MediaQuery.of(context).size.width / 2) - 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: AppColor().veryLightWhite,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImage().patientPrefix),
                                  const SizedBox(width: 8),
                                  Text(AppText().patients),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.2),
                            child: Container(
                              width: (MediaQuery.of(context).size.width / 2) - 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: AppColor().veryLightWhite,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImage().otherPrefix),
                                  const SizedBox(width: 8),
                                  Text(AppText().others),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomElevatedButtonOne(
                        buttonLabel: AppText().saveAddressButtonText,
                        backgroundColor: AppColor().red,
                        foregroundColor: AppColor().white,
                        buttonClickAction: () async => (),
                      )
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
