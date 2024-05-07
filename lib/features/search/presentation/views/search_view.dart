import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:parking_app/features/home/data/cubit/garages_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    location = extractLatLngFromGoogleMapLink(
        'https://maps.app.goo.gl/KYEdNKNGkywR5TAb7');
  }

  LatLng? location;
  double latitude = 0.0;
  double longitude = 0.0;
  LatLng? extractLatLngFromGoogleMapLink(String googleMapLink) {
    try {
      // Parse the original link
      Uri uri = Uri.parse(googleMapLink);

      // Get the redirected URL from the "q" query parameter
      String redirectedUrl = uri.queryParameters['q'] ?? '';

      // Parse the redirected URL
      Uri redirectedUri = Uri.parse(redirectedUrl);

      // Extract latitude and longitude from the redirected URL
      latitude =
          double.parse(redirectedUri.queryParameters['q']!.split(',')[0]);
      longitude =
          double.parse(redirectedUri.queryParameters['q']!.split(',')[1]);

      return LatLng(latitude, longitude);
    } catch (e) {
      print('Error parsing Google Maps link: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // LatLng location = const LatLng(0.1, 0.1);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              onChanged: (value) {},
              icon: Icons.search_off,
              hintText: 'Search here ...',
              suffixIcon: const Icon(Icons.filter_list_rounded),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text('Parking Points (${searchedList.length})',
            //       style: CustomTextStyles.openSansBoldStyle20Blue),
            // ),
            BlocConsumer<GaragesCubit, GaragesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state is GaragesDataLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is GaragesDataLoaded
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: state.garages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        imageUrl:
                                            state.garages[index].pictureUrl),
                                    title: Text(
                                      state.garages[index].name,
                                      style:
                                          CustomTextStyles.openSansBoldStyle20,
                                    ),
                                    subtitle: Text(
                                      state.garages[index].state
                                          ? 'Open'
                                          : 'Closed',
                                      style: TextStyle(
                                        color: state.garages[index].state
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                          )
                        : const Text('no data is available ');
              },
            )
          ],
        ),
      ),
    );
  }
}
