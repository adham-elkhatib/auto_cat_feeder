import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../Profile/pages/cat_profile.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CatProfile()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(bottom: 16.0),
      bodyAlignment: Alignment.center,
      titlePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('playful_cat.svg'),
              const SizedBox(height: 16),
              const Text(
                "Tell us about your cat",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body:
              "Start by sharing your cat's age and gender to create their profile.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('barcode.svg'),
              const SizedBox(height: 16),
              const Text(
                "Set Up Your Feeder",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body:
              "Next, you'll link your feeder to the app for seamless feeding.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('calendar.svg'),
              const SizedBox(height: 16),
              const Text(
                "Set a Feeding Schedule",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: "Plan and automate your cat's meals with just a few taps.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('adopt_pet.svg'),
              const SizedBox(height: 16),
              const Text(
                "Feed. Track. Relax.",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body:
              "Manage meals and monitor your cat’s health effortlessly with AI insights.",
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Get started',
          style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
