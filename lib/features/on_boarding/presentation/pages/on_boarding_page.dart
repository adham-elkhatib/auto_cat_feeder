import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../cat_profile/presentation/pages/cat_profile.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
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
              Text(
                LocaleKeys.on_boarding_pages_title_1.tr(),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: LocaleKeys.on_boarding_pages_body_1.tr(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('barcode.svg'),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.on_boarding_pages_title_2.tr(),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: LocaleKeys.on_boarding_pages_body_2.tr(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('calendar.svg'),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.on_boarding_pages_title_3.tr(),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: LocaleKeys.on_boarding_pages_body_3.tr(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage('adopt_pet.svg'),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.on_boarding_pages_title_4.tr(),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: LocaleKeys.on_boarding_pages_body_4.tr(),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: Text(
        LocaleKeys.on_boarding_actions_skip.tr(),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      next: const Icon(Icons.arrow_forward),
      done: Text(
        LocaleKeys.on_boarding_actions_done.tr(),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
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
