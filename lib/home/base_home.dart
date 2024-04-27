import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:room_automation/services/auth.dart';
import 'package:room_automation/services/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:room_automation/shared/home_nav.dart';

AnimatedText animatedTextMera(String textContent) {
  return TypewriterAnimatedText(
    textContent,
    speed: const Duration(milliseconds: 80),
    textStyle: GoogleFonts.montserrat(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
  );
}

class BaseHome extends StatelessWidget {
  const BaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset('assets/anim_home.json'),
          Text("RoomSync",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.bold)),
          AnimatedTextKit(
            animatedTexts: [
              animatedTextMera('Welcomes you...'),
              animatedTextMera('में आपका स्वागत है'),
              animatedTextMera('ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
