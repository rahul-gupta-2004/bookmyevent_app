import 'package:flutter/material.dart';
import 'package:seproject/organizers/create_event.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/organizers/og_login.dart' as orglogin;

class EditEvents extends StatefulWidget {
  const EditEvents({Key? key}) : super(key: key);

  @override
  State<EditEvents> createState() => _EditEventstate();
}

class _EditEventstate extends State<EditEvents> {
  static Map<String, dynamic> created_events = Create_event.created_events;
  //TODO change this shit to the depart of the org who is signed in
  static const dept = "ECC";
  Future<dynamic> events = ApiRequester.getEventbyDept(dept);
  @override
  Widget build(BuildContext context) {
    final organizer = orglogin.org;
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
                // Navigator.pushNamed(context, Routes.organizerHome);
                Navigator.pushReplacementNamed(
                  context,
                  Routes.organizerHome,
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),

                child: Text("EDIT EVENTS",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffECFFD1))),
              ),
              SizedBox(height: 20,),
              FutureBuilder(
                future: events,
                builder: (context, snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData) {
                    for (var event in snapshot.data) {
                      children.add(addBookedEvent(
                          event['eventId'],
                          event['eventName'],
                           event['organizer']['orgDept'],
                          event['url']));
                    }
                  }
                  return Column(
                    children: children,
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget addBookedEvent(eventId, eventName, organizer, image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context)!.size.width * 0.85,
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Color(golden_yellow)),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(image,
                          height: 150, width: 150, fit: BoxFit.cover),
                    ),
                    Column(
                      children: [
                        Container(
                            constraints: BoxConstraints.tight(Size(150, 25)),
                            child: Text(eventName,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(text_dm_offwhite),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))),
                        Container(
                            constraints: BoxConstraints.tight(Size(150, 25)),
                            child: Text(organizer,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(text_dm_offwhite),
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))),
                        // Text(organizer,
                        //     style: TextStyle(R
                        //       color: Color(text_dm_offwhite),
                        //       fontSize: 17,
                        //     )),
                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.green,
                        //       borderRadius: BorderRadius.circular(12.0)),
                        //   child: Row(
                        //     children: [
                        //       Text("  Created  ",
                        //           style: TextStyle(
                        //             color: Color(text_dm_offwhite),
                        //             fontSize: 15,
                        //           )),
                        //       Icon(Icons.done_all_rounded)
                        //     ],
                        //   ),
                        // ),
                        InkWell(
                          child: Container(
                              // color: Color(golden_yellow),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(golden_yellow)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.updateEvents, arguments: {
                                    'eventName': eventName,
                                    'eventId': eventId
                                  });
                                },
                                child: Text(
                                  "Update Event",
                                  style:
                                      TextStyle(color: Color(text_dm_offwhite)),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color.fromRGBO(255, 0, 0, 1)),
                              child: TextButton(
                                onPressed: () async {
                                  bool status =
                                      await ApiRequester.deleteEvent(eventName);
                                  if (status) {
                                    setState(() {
                                      events =
                                          ApiRequester.getEventbyDept(dept);
                                    });
                                    ;
                                  }
                                },
                                child: Text(
                                  "Delete Event",
                                  style:
                                      TextStyle(color: Color(text_dm_offwhite)),
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
