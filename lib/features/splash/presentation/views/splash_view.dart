import 'package:flutter/material.dart';
import 'package:parking_app/core/routes/routes.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    delayedNavigate(
        context,
        CacheHelper().getDataString(key: "token") == null
            ? onBoarding
            : homeNavbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Assets.imagesAppLogo)),
    );
  }
}
