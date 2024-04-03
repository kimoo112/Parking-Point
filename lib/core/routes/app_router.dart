import 'package:go_router/go_router.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:parking_app/features/home/presentation/views/home_navbar.dart';
import 'package:parking_app/features/home/presentation/views/home_view.dart';

import '../../features/auth/presentation/views/sign_in_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: splashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: onBoarding,
      builder: (context, state) => const OnBoardingView(),
    ),
    GoRoute(
      path: signUpView,
      builder: (context, state) => const SignUpView(),
    ),
      GoRoute(
      path: signInView,
      builder: (context, state) => const SignInView(),
    ),
      GoRoute(
      path: homeView,
      builder: (context, state) => const HomeView(),
    ),
      GoRoute(
      path: homeNavbar,
      builder: (context, state) => const HomeNavBarWidget(),
    ),
  ],
);
