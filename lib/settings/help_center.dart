import 'package:flutter/material.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

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
                  //     onPressed: () {
                  //       // Implement action to go back
                  //       Navigator.pop(context);
                  //     },
                  //     child: const Icon(Icons.arrow_back)),
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
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Help Center",
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
                      "Welcome to BookMyEvents",
                      style: TextStyle(
                        color: Color(text_dm_offwhite),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Getting Started',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'BookMyEvents is a platform designed to simplify the process of booking and managing college events. Whether you\'re a student looking for exciting activities to attend or a club organizing an event, our app has you covered.',
                      style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite),),
                      textAlign: TextAlign.justify
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'How to Use BookMyEvents',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite),),
                          textAlign: TextAlign.justify
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'For Students:\n'
                      '1. Sign Up: Create your account to start exploring events tailored to your interests.\n'
                      '2. Discover Events: Browse through a variety of events happening on your campus.\n'
                      '3. Book Tickets: Reserve your spot in your favorite events with just a few taps.\n'
                      '4. Stay Updated: Receive notifications and reminders about upcoming events.\n\n'
                      'For Clubs and Organizations:\n'
                      '1. Create an Event: Showcase your club\'s activities by creating and promoting events on our platform.\n'
                      '2. Manage Attendees: Easily keep track of attendees and communicate important event details.\n'
                      '3. Engage with Participants: Connect with students who share your club\'s interests and values.',
                      style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite),),
                      textAlign: TextAlign.justify
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Frequently Asked Questions (FAQs)',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'General',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'How do I contact support?\n'
                      'You can reach out to our support team by emailing [support@email.com] or using the in-app chat feature. We\'re here to help with any questions or concerns you may have.\n\n'
                      'Is [Your App Name] available on multiple platforms?\n'
                      'Yes, [Your App Name] is available for download on both iOS and Android devices.',
                      style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite),),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'For Students',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'How can I search for events?\n'
                      'You can search for events by category, date, location, or keyword using the search bar at the top of the app\'s homepage. You can also explore featured events and recommendations based on your preferences.\n\n'
                      'Can I invite friends to events?\n'
                      'Absolutely! You can share event details with friends through social media, messaging apps, or by sending them an invite directly from the app.',
                      style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite),),
                      textAlign: TextAlign.justify
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'For Clubs/Organizers',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(text_dm_offwhite),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'How do I create an event?\n'
                      'To create an event, log in to your account, navigate to the dashboard, and select "Create Event." Follow the prompts to fill in event details, such as date, time, location, and ticket information.\n\n'
                      'Can I manage multiple events simultaneously?\n'
                      'Yes, you can manage multiple events from your club\'s dashboard. Simply click on the event you wish to manage and make any necessary updates or changes.',
                      style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite),),
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
