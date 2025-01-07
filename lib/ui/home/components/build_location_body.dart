import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Widget buildLocationBody(BuildContext context) {
  return FlutterMap(
    options: const MapOptions(
      initialCenter: LatLng(23.774598, 90.421954),
      initialZoom: 13,
    ),
    children: [
      TileLayer(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: const ['a', 'b', 'c'],
      ),
      const MarkerLayer(
        markers: [
          Marker(
            point: LatLng(23.774598, 90.421954),
            width: 80,
            height: 80,
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ],
      ),
    ],
  );
}
