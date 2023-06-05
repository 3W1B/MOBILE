import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radon_app/models/logger.dart';

class MapWidget extends HookWidget {
  const MapWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {

    final latitude = logger.locations.first.latitude.toDouble();
    final longitude = logger.locations.first.longitude.toDouble();

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        final mapStyle = Theme.of(context).brightness == Brightness.dark
            ? '[{"featureType":"all","elementType":"all","stylers":[{"invert_lightness":true},{"saturation":10},{"lightness":30},{"gamma":0.5},{"hue":"#435158"}]}]'
            : null;
        controller.setMapStyle(mapStyle);
      },
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16.5),
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('RadonLogger'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'RadonLogger',
            snippet:
                '$latitude, $longitude',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      },
    );
  }
}
