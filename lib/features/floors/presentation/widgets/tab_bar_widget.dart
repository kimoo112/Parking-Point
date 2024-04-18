import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_colors.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        unselectedLabelColor: AppColors.primaryColor,
        indicatorColor: AppColors.black,
        padding: const EdgeInsets.all(16),
        dividerColor: AppColors.transparent,
        splashBorderRadius: BorderRadius.circular(50),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.offWhite,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w600, letterSpacing: .3),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.primaryColor),
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: AppColors.primaryColor)),
            child: Tab(
              text: '1st Floor '.toUpperCase(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: AppColors.primaryColor)),
            child: Tab(
              text: '2e Floor'.toUpperCase(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: AppColors.primaryColor)),
            child: Tab(
              text: '3e Floor'.toUpperCase(),
            ),
          ),
        ]);
  }
}
