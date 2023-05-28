import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends HookWidget {
  const GoogleMapsPage(
      {super.key, required this.title, required this.lat, required this.lng});

  final String title;
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, lng), zoom: 16.5),
            markers: <Marker>{
              Marker(
                markerId: MarkerId('RadonLogger'),
                position: LatLng(lat, lng),
                infoWindow: const InfoWindow(
                  title: 'RadonLogger',
                ),
                icon: BitmapDescriptor.defaultMarker,
              ),
            }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ));
  }
}
