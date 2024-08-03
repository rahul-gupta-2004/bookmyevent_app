import 'package:flutter/material.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/other/routes.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late Future<dynamic> matchedEvents = ApiRequester.getAllEvents();
  late String searchTerm = "";
  Widget addEventsTag(departmentName) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, "/department_list");
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              departmentName,
              style: TextStyle(fontSize: 18),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(background_darkgrey),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          setState(() {
                            searchTerm = value;
                            matchedEvents = ApiRequester.getEventbyName(value);
                          });
                        }
                      },
                      // onChanged: (value) => searchEvents(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.amber[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          labelText: 'Search',
                          suffixIcon: Icon(Icons.search))),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder(
                      future: matchedEvents,
                      builder: (context, snapshot) {
                        List<Widget> children = [];
                        if (snapshot.hasData) {
                          var eventsData = snapshot.data as List<dynamic>;
                          for (var event in eventsData) {
                            Widget builtEvent = addEvents(
                                event['eventId'],
                                event['eventName'],
                                event['organizer']['orgName'].toString(),
                                event['eventVenue'],
                                event['eventDesc'],
                                event['url'],
                                /* change this to event['url'] */
                                event['eventDateTime'],
                                event['eccPoints']);
                            children.add(builtEvent);
                          }
                        }
                        return Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 10.0,
                          runSpacing: 30.0,
                          children: children,
                        );
                      }),
                ]),
          ),
        ),
      ),
    );
  }

  Widget addEvents(eventId, eventName, organizer, eventVenue, eventDesc, image,
      eventDateTime, eccPoints) {
    return InkWell(
      onTap: () {
        print(eventVenue);
        Navigator.pushNamed(context, Routes.eventDescription, arguments: {
          'eventId': eventId.toString(),
          'eventName': eventName,
          'organizer': "Organizer name",
          'eventVenue': eventVenue,
          'eventDesc': eventDesc,
          'url': image,
          'isEventBooked': false,
          'eventDateTime': eventDateTime,
          'eccPoints': eccPoints,
        });
      },
      child: Container(
          padding: EdgeInsets.all(10),
          height: 170,
          width: 170,
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
}
