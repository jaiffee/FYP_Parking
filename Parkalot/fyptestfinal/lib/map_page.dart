// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   LatLng? _selectedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Location"),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: const CameraPosition(
//               target: LatLng(33.6844, 73.0479), // Default location: Islamabad
//               zoom: 14.0,
//             ),
//             onTap: (LatLng position) {
//               setState(() {
//                 _selectedLocation = position;
//               });
//             },
//             markers: _selectedLocation != null
//                 ? {
//                     Marker(
//                       markerId: const MarkerId("selectedLocation"),
//                       position: _selectedLocation!,
//                     ),
//                   }
//                 : {},
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             right: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_selectedLocation != null) {
//                   Navigator.pop(context, _selectedLocation);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Please select a location."),
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurpleAccent,
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//               ),
//               child: const Text(
//                 "Confirm Location",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
