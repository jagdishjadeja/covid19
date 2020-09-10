import 'package:covid19/tabview.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => TabView()),
    );
  }

  Widget _buildLottie(String assetName) {
    return Align(
      child: Lottie.asset('assets/$assetName.json',
          repeat: true, animate: true, height: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    final textcolor = Theme.of(context).textTheme.bodyText1.color;
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Covid 19 Tracker",
          body:
              "Get the Facts About Coronavirus Daily cases update around the world",
          image: _buildLottie('28663-coronavirus-covid-19'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Take steps to care for yourself and help protect others in your home and community.",
          image: _buildLottie('17949-corona-doctor'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Travel Advisories",
          body:
              "official travel advisories issued by governments across the globe.",
          image: _buildLottie('airplane'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Stay At Home",
          body:
              "If you have symptoms of COVID-19 however mild, self-isolate for at least 10 days from when your symptoms started.",
          image: _buildLottie('20546-i-stay-at-home'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Skip',
        style: TextStyle(color: textcolor),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: textcolor,
      ),
      done: Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: textcolor,
        ),
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
