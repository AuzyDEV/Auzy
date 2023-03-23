import 'package:flutter/material.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/splash_screen/components/second_view.dart';
import 'package:new_mee/splash_screen/components/center_next_button.dart';
import 'package:new_mee/splash_screen/components/mood_diary_vew.dart';
import 'package:new_mee/splash_screen/components/first_view.dart';
import 'package:new_mee/splash_screen/components/splash_view.dart';
import 'package:new_mee/splash_screen/components/top_back_skip_view.dart';
import 'package:new_mee/splash_screen/components/welcome_view.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
        body: Container(
      child: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController,
            ),
            FirstView(
              animationController: _animationController,
            ),
            SecondView(
              animationController: _animationController,
            ),
            ThirdView(
              animationController: _animationController,
            ),
            WelcomeView(
              animationController: _animationController,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController,
            ),
            CenterNextButton(
              animationController: _animationController,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(68, 154, 199, 235),
            Color.fromARGB(110, 197, 167, 246),
          ],
        ),
      ),
    ));
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController.value >= 0 && _animationController.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController.value > 0.8 &&
        _animationController.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController.value >= 0 && _animationController.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SigninWidget(),
      ),
    );
  }
}
