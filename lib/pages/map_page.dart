import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition pointInitial = CameraPosition(
        // target: LatLng(8.9472180, -75.4395881),
        target: scan.getLatLng(),
        zoom: 17,
        tilt: 50);

    //Markers
    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.location_history,
              color: Colors.red[700],
              size: 40,
            ),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getLatLng(), zoom: 17, tilt: 50)));
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        markers: markers,
        mapType: mapType,
        initialCameraPosition: pointInitial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
            setState(() {});
          }),
    );
  }
}
