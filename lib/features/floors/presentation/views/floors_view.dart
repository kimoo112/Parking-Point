import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/floors/data/cubit/pakyas_cubit.dart';
import 'package:parking_app/features/floors/data/models/pakyas_model.dart';

import '../../../../core/functions/navigation.dart';
import '../widgets/vertical_divider_widget.dart';

class FloorsView extends StatefulWidget {
  const FloorsView({Key? key}) : super(key: key);

  @override
  State<FloorsView> createState() => _FloorsViewState();
}

class _FloorsViewState extends State<FloorsView> {
  bool? isEmpty;
  @override
  void initState() {
    super.initState();
    if (context.read<PakyasCubit>().emptySensor == -1) {
      isEmpty = true;
    } else {
        isEmpty = false;

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PakyasCubit, PakyasState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Pakyas> pakyasList = [];
        int irSensor1 = -1;
        int irSensor2 = -1;
        int irSensor3 = -1;
        int irSensor4 = -1;

        if (state is PakyasDataLoaded) {
          pakyasList = state.pakyas;
          irSensor1 = context.read<PakyasCubit>().irSensor1;
          irSensor2 = context.read<PakyasCubit>().irSensor2;
          irSensor3 = context.read<PakyasCubit>().irSensor3;
          irSensor4 = context.read<PakyasCubit>().irSensor4;
        }

        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: !isEmpty!,
          appBar: AppBar(
            backgroundColor:isEmpty!?Colors.red: Colors.transparent,
            elevation: 0,
            title: isEmpty!
                ? const Text("The Garage is disconnected ")
                : null,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                if (state is PakyasDataLoading)
                  const CircularProgressIndicator()
                else
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      bool displayImage = false;
                      if ((index == 0 && irSensor1 == 0) ||
                          (index == 1 && irSensor2 == 0) ||
                          (index == 2 && irSensor3 == 0) ||
                          (index == 3 && irSensor4 == 0)) {
                        displayImage = true;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap:isEmpty!?(){}: () {
                                _confirmPaymentDialog(
                                    context, pakyasList, index, () {
                                  Navigator.of(context).pop();
                                  customNavigate(context, paymentView);
                                });
                              },
                              child: Container(
                                width: 111,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Transform.rotate(
                                  angle: math.pi / 2,
                                  child: Image.asset(
                                    "assets/images/floor_car.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (index % 2 == 0) const VerticalDividerWidget(),
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
            'Are you sure you want to book ${pakyasList[index].name!} floor in ${pakyasList[index].garage!} garage?',
          ),
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

  void _showGarageClosedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Garage Closed'),
          content: const Text('The Garage is disconnected from the internet'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
