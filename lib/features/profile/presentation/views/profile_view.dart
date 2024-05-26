import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../auth/cubit/auth_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadImage();
    context.read<AuthCubit>().getCarNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            'My Profile',
            style: CustomTextStyles.openSansBoldStyle20,
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                        radius: 65,
                        backgroundImage: context.read<AuthCubit>().imagePath ==
                                ''
                            ? const AssetImage(Assets.imagesProfilePicture)
                            : FileImage(
                                    File(context.read<AuthCubit>().imagePath))
                                as ImageProvider),
                    FloatingActionButton(
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        context.read<AuthCubit>().pickImageFromGallery();
                      },
                      mini: true,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.offWhite,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Name',
                    style: CustomTextStyles.openSans400style16,
                  ),
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    '${CacheHelper().getDataString(key: ApiKeys.name)}',
                    style: CustomTextStyles.openSansBoldStyle16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Email',
                    style: CustomTextStyles.openSans400style16,
                  ),
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    '${CacheHelper().getDataString(key: ApiKeys.email)}',
                    style: CustomTextStyles.openSansBoldStyle16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Car Number',
                    style: CustomTextStyles.openSans400style16,
                  ),
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    CacheHelper().getDataString(key: ApiKeys.carNumber) ??
                        context.read<AuthCubit>().carNumber,
                    style: CustomTextStyles.openSansBoldStyle16,
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.creditcard),
              title: Text(
                'Payment Info',
                style: CustomTextStyles.openSansBoldStyle16Black,
              ),
              trailing: Icon(Icons.arrow_circle_right_outlined,
                  color: AppColors.primaryColor),
              onTap: () {
                customNavigate(context, cardView);
              },
            ),
            CustomBtn(
                text: 'Logout'.toUpperCase(),
                borderRadius: 15,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          title: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Icon(
                                CupertinoIcons.power,
                                color: AppColors.primaryColor,
                                size: 70,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Are you sure to log out of your account?',
                                style: CustomTextStyles.openSans400style24,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                          actions: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: CustomBtn(
                                text: 'Log Out',
                                onPressed: () {
                                  CacheHelper().clearData();
                                  GoRouter.of(context)
                                      .pushReplacement(signInView);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: CustomBtn(
                                color: AppColors.black,
                                text: 'Cancel',
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                              ),
                            )
                          ],
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
