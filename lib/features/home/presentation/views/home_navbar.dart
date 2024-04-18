import 'package:flutter/material.dart';
import 'package:parking_app/features/floors/presentation/views/floors_view.dart';
import 'package:parking_app/features/home/presentation/views/home_view.dart';
import 'package:parking_app/features/profile/presentation/views/profile_view.dart';
import 'package:parking_app/features/search/presentation/views/search_view.dart';
import 'package:parking_app/features/timer/presentation/views/timer_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/utils/app_colors.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      controller: _controller,
      navBarStyle: NavBarStyle.style12,
      backgroundColor: AppColors.offWhite,
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 11,
              spreadRadius: 3,
              color: AppColors.grey.withOpacity(.8))
        ],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const HomeView(),
    const SearchView(),
    const TimerView(),
    const FloorsView(),
    const ProfileView(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      inactiveIcon: Icon(
        Icons.home_filled,
        color: AppColors.darkGrey,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search),
      inactiveIcon: Icon(
        Icons.search,
        color: AppColors.darkGrey,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.timer),
      inactiveIcon: Icon(
        Icons.timer,
        color: AppColors.darkGrey,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.edit_road_outlined),
      inactiveIcon: Icon(
        Icons.edit_road_outlined,
        color: AppColors.darkGrey,
      ),
    ),
     PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      inactiveIcon: Icon(
        Icons.person,
        color: AppColors.darkGrey,
      ),
    ),
  ];
}
