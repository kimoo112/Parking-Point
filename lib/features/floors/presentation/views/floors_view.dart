import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/floors/presentation/widgets/tab_bar_widget.dart';

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
    return Scaffold(
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
            _floorParking(),
            _floorParking(null, 'A04'),
            _floorParking('A05'),
            _floorParking(),
            _floorParking('A09'),
            _floorParking('A11'),
          ],
        ),
      ),
    );
  }

  Widget _floorParking([String? firstFloorName, String? secondFloorName]) {
    return Column(
      children: [
        const VerticalDividerWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            firstFloorName == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Assets.imagesFloorCar),
                  )
                : Container(
                    width: 111,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 2, color: AppColors.primaryColor)),
                    alignment: Alignment.center,
                    child: Text(
                      firstFloorName ,
                      style: CustomTextStyles.openSansBoldStyle16,
                    ),
                  ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(width: .5, color: AppColors.darkGrey)),
            ),
            secondFloorName == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Assets.imagesFloorCar),
                  )
                : Container(
                    width: 111,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 2, color: AppColors.primaryColor)),
                    alignment: Alignment.center,
                    child: Text(
                      secondFloorName ,
                      style: CustomTextStyles.openSansBoldStyle16,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
