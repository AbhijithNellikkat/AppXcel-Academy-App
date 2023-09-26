import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmptyBoxView extends StatelessWidget {
  const EmptyBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/animations/emptyBox.json"),
        Text(
          "Things look empty here. Tap + to start ",
          style: GoogleFonts.poppins(fontSize: 13),
        ),
      ],
    );
  }
}
