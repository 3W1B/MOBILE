import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radon_app/models/logger.dart';

class GoogleMapsWidget extends HookWidget {
  const GoogleMapsWidget({super.key, required this.logger});

  final Logger? logger;

  @override
  Widget build(BuildContext context) {
    if (logger == null) {
      return const Center(child: Text("No logger found"));
    }
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  logger!.locations[logger!.locations.length - 1].latitude
                      .toDouble(),
                  logger!.locations[logger!.locations.length - 1].longitude
                      .toDouble()),
              zoom: 16.5),
          markers: <Marker>{
            Marker(
              markerId: const MarkerId('RadonLogger'),
              position: LatLng(
                  logger!.locations[logger!.locations.length - 1].latitude
                      .toDouble(),
                  logger!.locations[logger!.locations.length - 1].longitude
                      .toDouble()),
              infoWindow: InfoWindow(
                title: 'RadonLogger',
                snippet:
                    'Current Location:\n${logger!.locations[logger!.locations.length - 1].latitude}, ${logger!.locations[logger!.locations.length - 1].longitude}',
              ),
              icon: BitmapDescriptor.defaultMarker,
            ),
          }),
    );
  }
}
