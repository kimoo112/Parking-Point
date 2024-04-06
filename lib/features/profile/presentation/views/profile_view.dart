import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'My Profile',
        style: CustomTextStyles.openSansBoldStyle20,
      )),
      body: SizedBox(
        width: double.infinity,
        child: Column(
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
                  child:  Icon(Icons.edit,color: AppColors.offWhite,),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomTextField(isHavePrefix: false,suffixIcon: Icons.person_3_sharp,hintText: 'First Name',),
            const CustomTextField(isHavePrefix: false,suffixIcon: Icons.person_3_sharp,hintText: 'Last Name',),
            const CustomTextField(isHavePrefix: false,suffixIcon: Icons.date_range_rounded,hintText: 'Date Of Birth',),
            const CustomTextField(isHavePrefix: false,suffixIcon: Icons.email,hintText: 'Email',),
            const CustomTextField(isHavePrefix: false,suffixIcon: Icons.phone,hintText: 'Phone Number',),
          ],
        ),
      ),
    );
  }
}
