import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/cubit/garages_cubit.dart';
import '../widgets/payment_container.dart';

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
    context.read<GaragesCubit>().fetchGaragesData();
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

  LatLng extractLatLngFromGoogleMapLink(String googleMapLink) {
    // Regular expression to extract latitude and longitude from Google Maps link
    RegExp regex = RegExp(
        r'https:\/\/www\.google\.com\/maps\/place\/@\s*(-?\d+\.\d+),\s*(-?\d+\.\d+)');

    // Match the regular expression against the link
    Match? match = regex.firstMatch(googleMapLink);

    if (match != null) {
      // Extract latitude and longitude from the matched groups
      double latitude = double.parse(match.group(1)!);
      double longitude = double.parse(match.group(2)!);
      return LatLng(latitude, longitude);
    } else {
      // Return null if no match is found
      return const LatLng(0.0, 0.0);
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
              ? BlocBuilder<GaragesCubit, GaragesState>(
                  builder: (context, state) {
                    if (state is GaragesDataLoading) {
                      return Stack(
                        children: [
                          const CircularProgressIndicator(),
                          FlutterMap(
                            options: MapOptions(
                              initialZoom: 11,
                              initialCenter: LatLng(_latitude!, _longitude!),
                              interactionOptions: const InteractionOptions(),
                            ),
                            children: [
                              openTileLayer,
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: [
                                      LatLng(_latitude!, _longitude!),
                                      LatLng(_latitude!, _longitude! + .1),
                                      LatLng(_latitude!, _longitude! + .2),
                                    ],
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
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
                                    child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const PaymentContainer();
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.blue,
                                        size: 60,
                                      ),
                                    ),
                                  ),
                                  Marker(
                                    point: LatLng(_latitude!, _longitude! + .2),
                                    width: 80,
                                    height: 80,
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const PaymentContainer();
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.blue,
                                        size: 60,
                                      ),
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
                      );
                    } else if (state is GaragesDataLoaded) {
                      return Stack(
                        children: [
                          FlutterMap(
                            options: MapOptions(
                              initialZoom: 11,
                              initialCenter: LatLng(_latitude!, _longitude!),
                              interactionOptions: const InteractionOptions(),
                            ),
                            children: [
                              openTileLayer,
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: [
                                      LatLng(_latitude!, _longitude!),
                                                    if (state.garages.isNotEmpty)
                    ...state.garages.map((garage) =>
                        extractLatLngFromGoogleMapLink(garage.locationUrl)).toList(),
                                    ],
                                    strokeWidth: 5,
                                    color: Colors.white,isDotted: true,
                                    strokeCap :StrokeCap.round
                                  ),
                                ],
                              ),
                              MarkerLayer(markers: [
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
                                ...List<Marker>.generate(
                                    state.garages.length,
                                    (index) => Marker(
                                        point: extractLatLngFromGoogleMapLink(
                                            state.garages[index].locationUrl),
                                        width: 80,
                                        height: 80,
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return PaymentContainer(
                                                  hourPrice: state
                                                      .garages[index].hourPrice,
                                                  parkingName:
                                                      state.garages[index].name,
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.blue,
                                            size: 60,
                                          ),
                                        )))
                              ])
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
                      );
                    }
                    return Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            initialZoom: 11,
                            initialCenter: LatLng(_latitude!, _longitude!),
                            interactionOptions: const InteractionOptions(),
                          ),
                          children: [
                            openTileLayer,
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: [
                                    LatLng(_latitude!, _longitude!),
                                    LatLng(_latitude!, _longitude! + .1),
                                    LatLng(_latitude!, _longitude! + .2),
                                  ],
                                  color: Colors.blue,
                                ),
                              ],
                            ),
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
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const PaymentContainer();
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.blue,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                Marker(
                                  point: LatLng(_latitude!, _longitude! + .2),
                                  width: 80,
                                  height: 80,
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const PaymentContainer();
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.blue,
                                      size: 60,
                                    ),
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
                    );
                  },
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
