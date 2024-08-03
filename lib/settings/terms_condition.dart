import 'package:flutter/material.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';

class TermsCondtion extends StatelessWidget {
  const TermsCondtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(background_darkgrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SafeArea(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(golden_yellow),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.settings);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(background_darkgrey),
                    )),
            )),
                SizedBox(
              height: 25,
            ),
            Text("Terms and Condition",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite))),
            SizedBox(
              height: 20,
            ),
            Text(
              "By accessing and using our services, you agree to abide by these terms and conditions. Users are responsible for the confidentiality of their account information and are prohibited from engaging in any unlawful activities on our platform. We reserve the right to modify or terminate services at our discretion, and users are encouraged to review these terms regularly for updates.",
              style: TextStyle(fontSize: 17, color: Color(text_dm_offwhite)),
              textAlign: TextAlign.justify,
            ),
          ]),
        ),
      ),
    );
  }
}
