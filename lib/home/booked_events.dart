import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:seproject/events/event_description.dart';
import 'package:seproject/events/ticket.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/organizers/og_login.dart';
import 'package:seproject/hive/hive.dart';

class BookedEvents extends StatefulWidget {
  const BookedEvents({Key? key}) : super(key: key);
  static bool isEventBooked = isEventBooked;

  @override
  State<BookedEvents> createState() => _BookedEventsState();
}

final myBox = HiveManager.myBox;
final user = myBox.get('CurUser');
final org = myBox.get('OrgAll');

class _BookedEventsState extends State<BookedEvents> {
  //
  static bool isEventBooked = false;
  static Map<String, dynamic>? tickets = EventDescription.tickets;

//change the snapshot thingy
  Future<dynamic> bookedEvents = ApiRequester.getBookedTickets(user['uid']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(background_darkgrey),
      appBar: AppBar(
        backgroundColor: Color(background_darkgrey),
        leading: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(golden_yellow),
                  borderRadius: BorderRadius.circular(20.0)),
              child: TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, Routes.bookedEvents);
                    Navigator.pushNamed(
                      context,
                      Routes.navigator,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            )),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: Color(golden_yellow),
                    //           borderRadius: BorderRadius.circular(20.0)),
                    //       child: TextButton(
                    //           onPressed: () {
                    //             // Navigator.pushNamed(context, Routes.bookedEvents);
                    //             Navigator.pushNamed(
                    //               context,
                    //               Routes.navigator,
                    //             );
                    //           },
                    //           child: Icon(
                    //             Icons.arrow_back,
                    //             color: Colors.black,
                    //           )),
                    //     )),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                        future: bookedEvents,
                        builder: (context, snapshot) {
                          List<Widget> children = [];
                          if (snapshot.hasData) {
                            String orgName = "";
                            for (var entry in snapshot.data["events"]) {
                              for (var o in org) {
                                print(o['orgId']);
                                print(entry);
                                if (o['orgId'] == entry['event']["orgId"]) {
                                  orgName = o['orgDept'];
                                  break;
                                }
                              }
                              dynamic event = entry["event"];
                              children.add(addBookedEvent(
                                  event["eventName"] ?? "",
                                  orgName,
                                  event["url"],
                                  event["eventDateTime"],
                                  event["eventVenue"]));
                            }
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: children,
                          );
                        })
                  ],
                ),
              )))),
    );
  }

  Widget addBookedEvent(
      eventName, organizer, image, eventDateTime, eventVenue) {
    final DateTime localTime = DateTime.parse(eventDateTime);
    final String eventDate = DateFormat.yMd().format(localTime);
    final String eventTime = DateFormat.jm().format(localTime);

    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, Routes.bookedTicket, arguments: {
          'eventName': eventName,
          'organizer': organizer,
          'eventDate': eventDate,
          'eventTime': eventTime,
          'eventVenue': eventVenue,
        })
      },
      child: Container(
        // width: MediaQuery.of(context)!.size.width * 0.75,
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Color(golden_yellow)),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(image,
                    height: 150, width: 150, fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      constraints: BoxConstraints.tight(Size(150, 25)),
                      child: Text(eventName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(text_dm_offwhite)),
                          overflow: TextOverflow.ellipsis)),

                  Container(
                      constraints: BoxConstraints.tight(Size(150, 25)),
                      child: Text(organizer,
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Color(text_dm_offwhite)),
                          overflow: TextOverflow.ellipsis)),
                  // Text(organizer,
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       color: Color(text_dm_offwhite)
                  //     ),
                  //     overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      children: [
                        Text("  Booked  ",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Icon(Icons.done_all_rounded)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
