import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seproject/events/event_description.dart';
import 'package:seproject/other/Image_pic_pre.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/other/routes.dart';

class Events extends StatefulWidget {
  final eventName,
      eventVenue,
      organizer,
      eventDate,
      eventDesc,
      eccPoints,
      maxCapacity;

  const Events(
      {Key? key,
      this.eventName,
      this.organizer,
      this.eventVenue,
      this.eventDate,
      this.eventDesc,
      this.eccPoints,
      this.maxCapacity})
      : super(key: key);
  // const Events({Key? key,}): super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Widget addEvents(eventId, eventName, organizer, eventVenue, eventDesc, image,
      eventDateTime, eccPoints) {
    return InkWell(
      onTap: () {
        print(eventVenue);
        Navigator.pushNamed(context, Routes.eventDescription, arguments: {
          'eventId': eventId.toString(),
          'eventName': eventName,
          'organizer': organizer,
          'eventVenue': eventVenue,
          'eventDesc': eventDesc,
          'url': image,
          'isEventBooked': false,
          'eventDateTime': eventDateTime,
          'eccPoints': eccPoints,
        });
      },
      child: Container(
          constraints: BoxConstraints.tight(Size(150, 150)),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(color: Color(golden_yellow)),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(image, width: 150, fit: BoxFit.cover),
                ),
              ),
              Text(
                eventName,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffECFFD1)),
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.left,
              ),
              Text(
                organizer,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xffECFFD1)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
    );
  }

  Widget eventsList(BuildContext context) {
    //TODO HIVEEEEEEEEEEEEEEEEEEEEEEEEEEE
    final Future<dynamic> events = ApiRequester.getAllEvents();

    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
            future: events,
            builder: (context, snapshot) {
              List<Widget> children = [];
              if (snapshot.hasData) {
                var eventsData = snapshot.data as List<dynamic>;
                for (var event in eventsData) {
                  Widget builtEvent = addEvents(
                      event['eventId'],
                      event['eventName'],
                      event['organizer']['orgDept'].toString(),
                      event['eventVenue'],
                      event['eventDesc'],
                      event['url'],
                      event['eventDateTime'],
                      event['eccPoints']);
                  children.add(builtEvent);
                }
              }
              return Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 15.0,
                children: children,
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181816),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffE1A730),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, Routes.navigator);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Text("EVENTS",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffECFFD1))),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: eventsList(context),
                  )
                ],
              )))),
    );
  }
}
