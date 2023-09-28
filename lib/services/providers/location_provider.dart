// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationProvider extends ChangeNotifier {
//   Position? _currentPosition;
//   String _currentAddress = '';
//   TextEditingController locationController = TextEditingController();

//   Position? get currentPosition => _currentPosition;
//   String? get currentAddress => _currentAddress;

//   Future<void> getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(
//           msg:
//               "Permission for accessing location is denied,Please go to settings and turn on");
//       return;
//     }

//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//       );

//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         _currentPosition = position;
//         _currentAddress =
//             "${place.locality}, ${place.postalCode}, ${place.country}";
//         locationController.text = _currentAddress;
//         notifyListeners();
//         notifyListeners();
//       }
//     } catch (e) {
//       log("Error getting location: $e");
//     }
//   }
// }
