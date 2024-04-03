import '../../../../core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding1,
    title: "Find Parking Spaces around you easily",
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding2,
    title: "Book and pay for your parking and security",
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding3,
    title: "Extend parking time",
  ),
];
