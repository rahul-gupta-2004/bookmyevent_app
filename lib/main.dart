// ignore_for_file: prefer_const_constructors

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:seproject/authentication/email_verification.dart';
import 'package:seproject/hive/hive.dart';
import 'package:seproject/home/booked_events.dart';
import 'package:seproject/home/upcoming.dart';
import 'package:seproject/organizers/create_event.dart';
import 'package:seproject/events/events.dart';
import 'package:seproject/events/event_description.dart';
import 'package:seproject/authentication/reset_password.dart';
import 'package:seproject/organizers/event_details.dart';
import 'package:seproject/organizers/og_home.dart';
import 'package:seproject/organizers/edit_events.dart';
import 'package:seproject/organizers/og_login.dart';
import 'package:seproject/organizers/past_events.dart';
import 'package:seproject/organizers/update_events.dart';
import 'package:seproject/search.dart';
import 'package:seproject/settings/about_us.dart';
import 'package:seproject/settings/help_center.dart';
import 'package:seproject/settings/privacy.dart';
import 'package:seproject/settings/settings.dart';
import 'package:seproject/settings/terms_condition.dart';
import 'package:seproject/settings/user_profile.dart';
import 'package:seproject/splash_screen.dart';
import 'package:seproject/events/ticket.dart';
import 'package:seproject/authentication/user_agreement.dart';
import 'package:seproject/authentication/password_verification.dart';
import 'authentication/login_page.dart';
import 'home/home_page.dart';
import 'authentication/signup.dart';
import 'other/routes.dart';
import 'other/screen_navigator.dart';
import 'package:hive/hive.dart';

void main() async {
//initialize hive
  await HiveManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      // initialRoute: Routes.createEvent,
      routes: {
        // "/": (context) => BookedEvents(),
        Routes.splashScreen: (context) => SplashScreen(),
        Routes.signUp: (context) => SignUpPage(),
        Routes.verifyEmail: (context) => EmailVerification(),
        Routes.agreement: (context) => UserAgreementPage(),
        Routes.loginPage: (context) => LoginPage(),
        Routes.verifyAccount: (context) => VerificationPage(),
        Routes.resetPassword: (context) => ResetPasswordPage(),
        Routes.navigator: (context) => BottomNavbar(),
        Routes.homePage: (context) => HomePage(),
        Routes.events: (context) => Events(),
        Routes.eventDescription: (context) => EventDescription(),
        Routes.bookedTicket: (context) => BookedTicket(),
        Routes.search: (context) => SearchSection(),
        Routes.settings: (context) => SettingsPage(),
        Routes.userProfile: (context) => Profile(),
        Routes.aboutUs: (context) => AboutUsPage(),
        Routes.privacy: (context) => Privacy(),
        Routes.termsConditons: (context) => TermsCondtion(),
        Routes.helpCenter: (context) => HelpCenter(),
        Routes.organizerLogin: (context) => OrganizerLogin(),
        Routes.organizerHome: (context) => OrganizerHomePage(),
        Routes.createEvent: (context) => Create_event(),
        Routes.bookedEvents: (context) => BookedEvents(),
        Routes.upcomingEvents: (context) => Upcoming(),
        Routes.editEvents: (context) => EditEvents(),
        Routes.updateEvents: (context) => UpdateEvents(),
        Routes.pastEvents: (context) => PastEvents(),
        Routes.eventDetails: (context) => EventDetails(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
