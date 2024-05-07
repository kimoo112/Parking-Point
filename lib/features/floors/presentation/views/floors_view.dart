import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/floors/data/cubit/pakyas_cubit.dart';
import 'package:parking_app/features/floors/data/models/pakyas_model.dart';
import 'package:parking_app/features/floors/presentation/widgets/tab_bar_widget.dart';

import '../../../../core/functions/navigation.dart';
import '../widgets/vertical_divider_widget.dart';

class FloorsView extends StatefulWidget {
  const FloorsView({Key? key}) : super(key: key);

  @override
  State<FloorsView> createState() => _FloorsViewState();
}

class _FloorsViewState extends State<FloorsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PakyasCubit, PakyasState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Pakyas> pakyasList = [];
        if (state is PakyasDataLoaded) {
          pakyasList = state.pakyas;
        }
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBarWidget(tabController: _tabController),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Entrance',
                    style: CustomTextStyles.openSansBoldStyle20,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 15,
                ),
                state is PakyasDataLoading
                    ? const CircularProgressIndicator()
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: pakyasList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _confirmPaymentDialog(
                                        context, pakyasList, index, () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      customNavigate(context, paymentView);
                                    });
                                  },
                                  child: Container(
                                    width: 111,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(.2),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      pakyasList[index].name!,
                                      style:
                                          CustomTextStyles.openSansBoldStyle16,
                                    ),
                                  ),
                                ),
                              ),
                              if (index % 2 ==
                                  0) // Show VerticalDivider if index is not even
                                const VerticalDividerWidget(),
                            ],
                          );
                        },
                      ),
                const Divider(
                  thickness: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _confirmPaymentDialog(BuildContext context,
      List<Pakyas> pakyasList, int index, void Function()? onPressed) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Text(
              'Are you sure you want to book ${pakyasList[index].name!} floor in ${pakyasList[index].garage!} garage?'),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
