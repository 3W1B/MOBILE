import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radon_app/models/logger.dart';

class MapWidget extends HookWidget {
  const MapWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
          target: LatLng(logger!.locations.first.latitude.toDouble(),
              logger!.locations.first.longitude.toDouble()),
          zoom: 16.5),
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('RadonLogger'),
          position: LatLng(logger!.locations.first.latitude.toDouble(),
              logger!.locations.first.longitude.toDouble()),
          infoWindow: InfoWindow(
            title: 'RadonLogger',
            snippet:
                'Current Location:\n${logger!.locations.first.latitude}, ${logger!.locations.first.longitude}',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      },
    );
  }
}
