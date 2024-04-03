import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double? _latitude;
  double? _longitude;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _isLoading = false;
        });
      } catch (e) {
        debugPrint("Error: $e");
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      debugPrint("Location permission is not granted.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          : _latitude != null && _longitude != null
              ? Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        initialZoom: 11,
                        initialCenter: LatLng(_latitude!, _longitude!),
                        interactionOptions: const InteractionOptions(),
                      ),
                      children: [
                        openTileLayer,
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(_latitude!, _longitude!),
                              width: 80,
                              height: 80,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.red,
                                size: 60,
                              ),
                            ),
                            Marker(
                              point: LatLng(_latitude!, _longitude! + .1),
                              width: 80,
                              height: 80,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 60,
                              ),
                            ),
                            Marker(
                              point: LatLng(_latitude!, _longitude! + .2),
                              width: 80,
                              height: 80,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomBtn(
                          text: 'Where To Park ?',
                          marginSize: 16,
                        ))
                  ],
                )
              : const Center(
                  child: Text('Failed to obtain location.'),
                ),
    );
  }
}

TileLayer get openTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.parking_app',
    );
