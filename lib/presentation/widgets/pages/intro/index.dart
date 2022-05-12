import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';

const descriptions = [
  "Bu ilova O'ZBEKISTON RESPUBLIKASI OLIY VA O'RTA MAXSUS TA'LIM VAZIRINING 2021-yil 30-sentyabrdagi 412- sonli buyrug'i ijrosini ta'minlash maqsadida yaratildi",
  "Ish faoliyatida qog'ozbozlikni oldini oladi",
  "Tyutorlik faoliyatida tahliliy nazoratni amalga oshiriladi",
];

const descStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  Function goToTab = () {};
  int currentTab = 0;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        widgetDescription: Text(
          descriptions[0],
          textAlign: TextAlign.center,
          style: descStyle,
        ),
        pathImage: "assets/images/logo2.png",
        backgroundColor: primaryColor,
      ),
    );
    slides.add(
      Slide(
        widgetDescription: Text(
          descriptions[1],
          textAlign: TextAlign.center,
          style: descStyle,
        ),
        pathImage: "assets/images/papers.png",
        backgroundColor: primaryColor,
      ),
    );
    slides.add(
      Slide(
        widgetDescription: Text(
          descriptions[2],
          textAlign: TextAlign.center,
          style: descStyle,
        ),
        pathImage: "assets/images/control.png",
        backgroundColor: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      showSkipBtn: false,
      renderPrevBtn: TextButton(
        onPressed: () {
          setState(() {
            currentTab -= 1;
          });
          goToTab(currentTab);
        },
        child: const Icon(
          Icons.navigate_before,
          size: 25,
          color: Colors.white,
        ),
      ),
      renderNextBtn: TextButton(
        onPressed: () {
          setState(() {
            currentTab += 1;
          });
          goToTab(currentTab);
        },
        child: const Icon(
          Icons.navigate_next,
          size: 25,
          color: Colors.white,
        ),
      ),
      colorDot: Colors.white38,
      colorActiveDot: Colors.white,
      slides: slides,
      renderDoneBtn: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/start_auth');
        },
        child: Text(
          AppLocalization.of(context)!.translate('login'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onDonePress: () {
        Navigator.of(context).pushNamed('/start_auth');
      },
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },
    );
  }
}
