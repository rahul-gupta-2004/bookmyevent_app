import 'package:flutter/material.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(background_darkgrey),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ElevatedButton(
                    
                  //   onPressed: () {
                  //     // Implement action to go back
                  //     Navigator.pop(context);
                  //   },
                  //   child: Icon(Icons.arrow_back, color: Color(background_darkgrey),),
                  // ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: Color(text_dm_offwhite),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Effective date: January 1, 2024",
                      style: TextStyle(
                        color: Color(text_dm_offwhite),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Your privacy is important to us. It is [Your Company]'s policy to respect your privacy regarding any information we may collect from you through our app, [Your App Name], and other sites we own and operate.\n"
                      "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent.\n"
                      "We also let you know why we’re collecting it and how it will be used.\n"
                      "We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use, or modification.\n"
                      "We don’t share any personally identifying information publicly or with third-parties, except when required to by law.\n"
                      "Our app may link to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and cannot accept responsibility or liability for their respective privacy policies.\n"
                      "You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.\n"
                      "Your continued use of our app will be regarded as acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, feel free to contact us.\n"
                      "\nThis policy is effective as of 1 January 2024.",
                      style: TextStyle(
                        color: Color(text_dm_offwhite),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify
                    ),
                  ),
                  Divider(
                    height: 15,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                    color: Color(text_dm_offwhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
