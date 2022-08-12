
class OnBoardingModel {
  String image;
  String title;
  String subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> pages = [
  OnBoardingModel(
      image: 'assets/images/onboarding_1.webp',
      title: 'Shop App',
      subTitle: 'Welcome in Shop App , Register to enjoy our hot offers'),
  OnBoardingModel(
      image: 'assets/images/onboarding_2.webp',
      title: 'Interested',
      subTitle: 'Our Shop App offers you a lot of interesting offers to spend your time and enjoy in your spare time'),
  OnBoardingModel(
      image: 'assets/images/onboarding_5.jpg',
      title: 'Your comfort is important to us',
      subTitle: 'With Shop app, you don\'t need to go out of the house to shop , you just need your phone'),
  OnBoardingModel(
      image: 'assets/images/onboarding_9.webp',
      title: 'LOG IN',
      subTitle: 'Welcome to our little family, log in and enjoy with us'),
];