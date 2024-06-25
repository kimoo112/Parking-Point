import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:parking_app/features/home/data/cubit/garages_cubit.dart';

import '../../../home/presentation/widgets/payment_container.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Navigator.canPop(context)
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      )
                    : const SizedBox(),
                Flexible(
                  child: CustomTextField(
                    onChanged: (value) {},
                    icon: Icons.search_off,
                    hintText: 'Search here ...',
                    suffixIcon: const Icon(Icons.filter_list_rounded),
                  ),
                ),
              ],
            ),
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
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 33,
                                    backgroundImage: CachedNetworkImageProvider(
                                      state.garages[index].pictureUrl,
                                    ),
                                  ),
                                  title: Text(
                                    state.garages[index].name,
                                    style: CustomTextStyles.openSansBoldStyle20,
                                  ),
                                  subtitle: Text(
                                    state.garages[index].state
                                        ? 'Open'
                                        : 'Closed',
                                    style: CustomTextStyles
                                        .openSans400style16Black
                                        .copyWith(
                                      color: state.garages[index].state
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return PaymentContainer(
                                          hourPrice:
                                              state.garages[index].hourPrice,
                                          parkingName:
                                              state.garages[index].name,
                                              onPressed: index == 1 ? (){
customNavigate(context, closedFloorsView);
                                              } : null
                                        );
                                      },
                                    );
                                  },
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
