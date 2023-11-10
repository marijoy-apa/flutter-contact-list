import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: CircleAvatar(
            minRadius: 30,
            backgroundColor: Theme.of(context).iconTheme.color!.withOpacity(.7),
            child: Lottie.asset('assets/contactList.json', height: 125)),
        duration: 2000,
        splashIconSize: 150,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(1),
        nextScreen: const ContactsScreen());
  }
}
