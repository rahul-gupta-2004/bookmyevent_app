import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:seproject/home/booked_events.dart';
import 'package:seproject/events/events.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/other/date_pick.dart';
import 'package:seproject/other/time_pick.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/hive/hive.dart';

class EventDescription extends StatefulWidget {
  final eventName, organiser, img;
  final isEventBooked;
  // static bool isBooked = false;
  // static bool isEventBooked = _EventDescriptionState.isEventBooked;
  static Map<String, dynamic> tickets = _EventDescriptionState.tickets;

  const EventDescription(
      {Key? key, this.eventName, this.organiser, this.img, this.isEventBooked})
      : super(key: key);

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

final myBox = HiveManager.myBox;
final user = myBox.get('CurUser');

class _EventDescriptionState extends State<EventDescription> {
  static List<String> bookedEvents = [];
  static Map<String, dynamic> tickets = {};

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
    final url = args?['url'];
    final eventDesc = args?['eventDesc'] ?? "";
    final eventDateTime = args?['eventDateTime'];
    var isEventBooked = args?['isEventBooked'] ?? '';

    final DateTime localTime = DateTime.parse(eventDateTime);
    final String eventDate = DateFormat.yMd().format(localTime);
    final String eventTime = DateFormat.jm().format(localTime);

    return Scaffold(
        backgroundColor: Color(0xff181816),
        // appBar: AppBar(
        //   foregroundColor: Color(0xffE1A730)
        // ),
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
                    if (!bookedEvents.contains(eventName)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Color(background_darkgrey),
                              title: Text("Booking Confirmation", style: TextStyle(color: Color(text_dm_offwhite)),),
                              content: Text(
                                  "Are you sure about booking this event?", style: TextStyle(color: Color(text_dm_offwhite))),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel", style: TextStyle(color: Color(golden_yellow))),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // print(eventName);
                                    // bookedEvents.add(eventName);
                                    // tickets['eventName'] = eventName;
                                    // tickets['organizer'] = organizer;
                                    // print(bookedEvents);
                                    // await Future.delayed(Duration(seconds: 1));
                                    bool status =
                                        await ApiRequester.addBookedTicket(
                                            user['uid'], int.parse(eventId));
                                    //TODO Fucking remove this static UID when and if hive shows up
                                    print(status);
                                    if (status) {
                                      // TODO Make this shit go back to the home page after someone clicks on this
                                      Navigator.pushNamed(
                                          context, Routes.bookedTicket,
                                          arguments: {
                                            'eventName': eventName,
                                            'organizer': organizer,
                                            'eventDate': eventDate,
                                            'eventTime': eventTime,
                                            'eventVenue': eventVenue
                                          });
                                    }
                                  },
                                  child: Text("Proceed", style: TextStyle(color: Color(golden_yellow))),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: bookedEvents.contains(eventName)
                            ? Colors.grey
                            : Color(0xffE1A730),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              bookedEvents.contains(eventName)
                                  ? "Already Booked"
                                  : "Book Now",
                              style: bookedEvents.contains(eventName)
                                  ? TextStyle(fontSize: 20, color: Colors.white)
                                  : TextStyle(fontSize: 20)),
                          Icon(
                            Icons.arrow_forward,
                            color: bookedEvents.contains(eventName)
                                ? Colors.white
                                : Colors.black,
                          )
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
