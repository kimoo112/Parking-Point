import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

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
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage(Assets.imagesProfilePicture),
                ),
                FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {},
                  mini: true,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.offWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'My Name ',
              style: CustomTextStyles.openSansBoldStyle20,
            ),
            Text(
              '${CacheHelper().getDataString(key: ApiKeys.name)}',
              style: CustomTextStyles.openSansBoldStyle20Blue,
            ),
            const Divider(),
            Text(
              'My Email ',
              style: CustomTextStyles.openSansBoldStyle20,
            ),
            Text(
              '${CacheHelper().getDataString(key: ApiKeys.email)}',
              style: CustomTextStyles.openSansBoldStyle20Blue,
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
                                  CacheHelper().removeData(key: ApiKeys.token);
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
