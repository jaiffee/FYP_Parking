import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  final String address;

  const MapScreen({Key? key, required this.address}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _targetPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _convertAddressToLatLng(widget.address);
  }

  Future<void> _convertAddressToLatLng(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final latLng = LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          _targetPosition = latLng;
          _markers.add(
            Marker(
              markerId: const MarkerId("parking_location"),
              position: latLng,
              infoWindow: const InfoWindow(title: "Parking Location"),
            ),
          );
          _isLoading = false;
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
      } else {
        print("No location found for the address.");
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print("Error getting location from address: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parking Location")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _targetPosition == null
          ? const Center(child: Text("Could not find location."))
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _targetPosition!,
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: _markers,
      ),
    );
  }
}
