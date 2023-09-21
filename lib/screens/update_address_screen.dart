import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'add_address_screen.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  TextEditingController addressController = TextEditingController();
  Placemark? placeMark;
  static CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(28.537321777049026, 77.26471398622849),
    zoom: 14,
  );
  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.537321777049026, 77.26471398622849),
      infoWindow: InfoWindow(title: "The Title of Marker"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: GoogleMap(
                      buildingsEnabled: true,
                      mapType: MapType.satellite,
                      fortyFiveDegreeImageryEnabled: true,
                      initialCameraPosition: _cameraPosition,
                      markers: markers,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 35, left: 20),
                    child: Text(
                      "Select your location",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "YOUR LOCATION",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: addressController,
                            style: const TextStyle(fontSize: 18),
                            enabled: false,
                            decoration: const InputDecoration(
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20),
                    child: Divider(
                      color: Colors.black,
                      height: 3,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff4a85),
                        ),
                        onPressed: () {
                          if (addressController.text.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAddressScreen(
                                  placeMark: placeMark,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            "Confirm Location and Proceed",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        final Position currentPosition =
                            await getCurrentLocation();
                        final LatLng newPosition = LatLng(
                          currentPosition.latitude,
                          currentPosition.longitude,
                        );
                        markers.clear();
                        markers.add(
                          Marker(
                            markerId: const MarkerId('2'),
                            position: newPosition,
                            infoWindow:
                                const InfoWindow(title: "Current Location"),
                          ),
                        );
                        _cameraPosition = CameraPosition(
                          target: newPosition,
                          zoom: 17,
                        );
                        final GoogleMapController controller =
                            await _mapController.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(_cameraPosition));
                        setState(() {});

                        final List<Placemark> coordinatePlaceMarks =
                            await placemarkFromCoordinates(
                          newPosition.latitude,
                          newPosition.longitude,
                        );

                        if (coordinatePlaceMarks.isNotEmpty) {
                          placeMark = coordinatePlaceMarks[0];
                          final String address =
                              placeMark?.street ?? "Unknown Street";
                          final String locality =
                              placeMark?.locality ?? "Unknown Locality";
                          final String postalCode =
                              placeMark?.postalCode ?? "Unknown Postal Code";
                          addressController.text =
                              "${placeMark?.street},${placeMark?.subLocality},${placeMark?.locality},${placeMark?.country},${placeMark?.postalCode}";
                          print(
                              "Complete Address: $address, $locality, $postalCode");
                        }
                      },
                      icon: const Icon(
                        Icons.location_searching,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission().catchError((error) {
      print(error);
    });
    return await Geolocator.getCurrentPosition();
  }
}
