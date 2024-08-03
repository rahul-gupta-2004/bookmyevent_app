import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  static bool isEventBooked = false;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final eventId = args?['eventId'] ?? "";
    final eventName = args?['eventName'] ?? "";
    final organizer = args?['organizer'] ?? "";
    final eventVenue = args?['eventVenue'] ?? "";
    final eccPoints = args?['eccPoints'] ?? "";
    final image = args?['image'] ?? "";
    final url = args?['url'] ?? "";
    final eventDesc = args?['eventDesc'] ?? "";
    final eventDateTime = args?['eventDateTime'] ?? "";
    var isEventBooked = args?['isEventBooked'] ?? '';

    final DateTime localTime = DateTime.parse(eventDateTime);
    final String eventDate = DateFormat.yMd().format(localTime);
    final String eventTime = DateFormat.jm().format(localTime);

    return Scaffold(
        backgroundColor: Color(0xff181816),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE1A730),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.push
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Image.network(
                      url,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.fitWidth,
                    )),
                Text(
                  eventName,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffECFFD1)),
                ),
                Text(
                  organizer,
                  style: TextStyle(fontSize: 17, color: Color(0xffECFFD1)),
                ),
                Row(
                  children: [
                    Icon(Icons.date_range, color: Color(0xffECFFD1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Date: $eventDate",
                      style: TextStyle(fontSize: 16, color: Color(0xffECFFD1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.timer_rounded, color: Color(0xffECFFD1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Time: $eventTime",
                      style: TextStyle(fontSize: 16, color: Color(0xffECFFD1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Color(0xffECFFD1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Venue: $eventVenue",
                      style: TextStyle(fontSize: 16, color: Color(0xffECFFD1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Color(0xffECFFD1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ecc Points: $eccPoints",
                      style: TextStyle(fontSize: 16, color: Color(0xffECFFD1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    eventDesc,
                    // child: Text(
                    //   "Marshall Bruce Mathers III (born October 17, 1972)—otherwise known as Eminem—is a legendary hip-hop icon who started as an underground battle rapper in Detroit, Michigan. He developed a career full of controversy, wild swings, and some of the most noteworthy bars in the history of the genre.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    bool status = await ApiRequester.generateRegPage(eventId);
                    if (status) {
                      if (!await launchUrl(
                          Uri.parse(ApiRequester.buildUrl('event$eventId.csv')),
                          mode: LaunchMode.externalApplication)) {
                        print("Launch failed perhaps");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("No data for this event")));
                    }
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffE1A730),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("Download Registration page!")]),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
