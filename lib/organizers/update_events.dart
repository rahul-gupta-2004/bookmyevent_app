import 'package:flutter/material.dart';
import 'package:seproject/organizers/create_event.dart';
import 'package:seproject/other/Image_pic_pre.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/date_pick.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/time_pick.dart';
import 'package:seproject/hive/hive.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/other/routes.dart';

final myBox = HiveManager.myBox;
final org = myBox.get('CurrentOrg');

class UpdateEvents extends StatefulWidget {
  final eventName;
  static Map<String, dynamic> updated_events =
      _UpdateEventsState.updated_events;
  const UpdateEvents({Key? key, this.eventName}) : super(key: key);

  @override
  State<UpdateEvents> createState() => _UpdateEventsState();
}

class _UpdateEventsState extends State<UpdateEvents> {
  TextEditingController updatedEventName = TextEditingController();
  TextEditingController updatedEventVenue = TextEditingController();
  TextEditingController updatedEventDesc = TextEditingController();
  TextEditingController points = TextEditingController();
  TextEditingController captroller = TextEditingController();
  String eventDate = DateSelectionScreen.eventDate;
  static Map<String, dynamic> created_events = Create_event.created_events;

  static Map<String, dynamic> updated_events = {};

  final List<String> collaborators = [
    "ECC",
    "Fitoor",
    "Ithaka",
    "LFL",
    "MVM",
    "Wpa Dance"
  ];
  String collaborator = "";
  int collaboratorId = 0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? eventDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final eventName = eventDetails?['eventName'] ?? "";
    final eventId = eventDetails?['eventId'] ?? "";
    final Future<dynamic> collabData = ApiRequester.getAllOrganizers();
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
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // Set grey background color
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update Event",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(text_dm_offwhite)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Upload Event Image :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              SizedBox(
                height: 20,
              ),
              Image_pic_pre(),
              SizedBox(
                height: 40,
              ),
              Text(
                " Update Event Name :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              InputField(
                hintText: 'Update Event Name',
                controller: updatedEventName,
                // defaultValue: created_events['eventName'] ?? "",
              ),
              SizedBox(height: 30.0),
              Text(
                " Update Event Date :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              SizedBox(
                height: 8,
              ),
              DateSelectionScreen(),
              SizedBox(height: 30.0),
              Text(
                " Update Event Time :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              SizedBox(
                height: 8,
              ),
              TimeSelectionScreen(),
              SizedBox(height: 30.0),
              Text(
                " Update Event Venue :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              InputField(
                hintText: 'Update Event Venue',
                controller: updatedEventVenue,
                // defaultValue: created_events['eventVenue'] ?? "",
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 25,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Color(golden_yellow),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                " Update Event ECC Points : ",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: points,
                  decoration: InputDecoration(
                    hintText: "Update Event ECC Points ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Color(text_dm_offwhite),
                  )),
              SizedBox(height: 30.0),
              Text(
                " Update Event Max Capacity :",
                style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite)),
              ),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: captroller,
                  decoration: InputDecoration(
                    hintText: "Update Event Max Capacity ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Color(text_dm_offwhite),
                  )),
              SizedBox(
                height: 30,
              ),
              Text(
                " Update Event Description :",
                style: TextStyle(fontSize: 18, color: Color(text_dm_offwhite)),
              ),
              TextFormField(
                  maxLines: 8,
                  controller: updatedEventDesc,
                  // initialValue: created_events['eventDesc'] ?? "",
                  decoration: InputDecoration(
                    hintText: "Update Event Description ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Color(text_dm_offwhite),
                  )),
              SizedBox(
                height: 30,
              ),
              Divider(
                height: 25,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Color(golden_yellow),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Chose the organizer department",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(text_dm_offwhite)),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: collabData,
                builder: ((context, snapshot) {
                  List<Widget> children;
                  children = [];
                  if (snapshot.hasData) {
                    var organizerData = snapshot.data as List<dynamic>;
                    for (var elem in organizerData) {
                      children.add(RadioOpt(elem));
                      children.add(
                        const SizedBox(
                          height: 20,
                        ),
                      );
                    }
                  }
                  // children.removeLast();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  );
                }),
              ),
              SizedBox(
                height: 100,
              ),
              Card(
                color: Color(golden_yellow),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(width: 1.0),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      "Update Event ",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(background_darkgrey)),
                    ),
                  ),
                  onTap: () async {
                    // print(eventName);
                    // created_events['eventName'] = eventName.text;
                    // created_events['organizer'] = collaborator;
                    // created_events['eventVenue'] = updatedEventVenue.text;
                    // created_events['eventDate'] = eventDate;
                    // created_events['eventDesc'] = updatedEventDesc.text;

                    DateTime? date = DateSelectionScreen.dateObj;
                    TimeOfDay? time = TimeSelectionScreen.timeObj;
                    DateTime? eventDateTime;
                    if (date != null && time != null) {
                      eventDateTime = DateTime(date!.year, date.month, date.day,
                          time!.hour, time.minute);
                    }
                    String fname = "";
                    String? upStatus = await Image_pic_pre.upload();
                    fname = upStatus ?? "";

                    Map<String, dynamic> data = {
                      "eventId": eventId.toString(),
                      "orgId": org["orgId"].toString(),
                      "tagId": 5.toString(), //deprecated perchance
                      "eventName": updatedEventName.text,
                      "eventDateTime": eventDateTime?.toIso8601String(),
                      "eventVenue": updatedEventVenue.text,
                      "maxCapacity": captroller.text,
                      "eccPoints": points.text,
                      "description": updatedEventDesc.text,
                      "colaborator1": collaboratorId.toString(),
                      "url": fname,
                    };
                    List<String> removal = [];
                    for (var val in data.entries) {
                      if (val.value == null || val.value.toString().isEmpty) {
                        removal.add(val.key);
                      }
                    }
                    for (var val in removal) {
                      data.remove(val);
                    }

                    if (data['url'] != null) {
                      data['url'] = ApiRequester.buildUrl(data['url']);
                    }
                    bool status = await ApiRequester.updateEvents(data);
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.organizerHome);
                    print("Addition succeeded: ${status.toString()}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row RadioOpt(elem) {
    return Row(
      children: [
        Radio(
            toggleable: true,
            value: elem['orgDept'] as String,
            groupValue: collaborator,
            activeColor: Color(golden_yellow),
            onChanged: (String? value) {
              setState(() {
                collaborator = elem['orgDept'].toString();
                collaboratorId = elem['orgId'];
                print(collaborator);
              });
            }),
        SizedBox(width: 8),
        Text(elem['orgDept'] as String,
            style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite))),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final controller;

  const InputField({Key? key, required this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // initialValue: defaultValue,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Color(text_dm_offwhite),
      ),
    );
  }
}
