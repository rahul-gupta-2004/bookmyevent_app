import 'package:flutter/material.dart';
import 'package:seproject/home/booked_events.dart';
import 'package:seproject/other/routes.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../other/color_palette.dart';
import 'package:seproject/hive/hive.dart';

class BookedTicket extends StatefulWidget {
  final eventName, organiser, img, eventDate, eventTime, eventVenue;
  BookedTicket(
      {Key? key,
      this.eventName,
      this.organiser,
      this.img,
      this.eventDate,
      this.eventTime,
      this.eventVenue})
      : super(key: key);

  @override
  State<BookedTicket> createState() => _BookedTicketState();
}

final myBox = HiveManager.myBox;
final user = myBox.get('CurUser');

class _BookedTicketState extends State<BookedTicket> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? eventDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: Color(background_darkgrey),
      appBar: AppBar(
        backgroundColor: Color(background_darkgrey),
        // foregroundColor: Color(golden_yellow)
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TicketWidget(
                  color: Color(golden_yellow),
                  width: 350,
                  height: 520,
                  isCornerRounded: true,
                  padding: EdgeInsets.all(20),
                  child: TicketData(),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      constraints: BoxConstraints.tight(Size(200, 50)),
                      decoration: BoxDecoration(
                          color: Color(0xffE1A730),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.navigator);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              Text(
                                "return to home",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(background_darkgrey)),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                    )),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> nameSpl = (user["name"] as String).split(" ");
    if (nameSpl.length > 1) {
      user["name"] = nameSpl[0];
      user["sname"] = nameSpl[1];
    }

    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final eventName = args?['eventName'] ?? '';
    final organizer = args?['organizer'] ?? '';
    final eventDate = args?['eventDate'] ?? '';
    final eventTime = args?["eventTime"] ?? '';
    final eventVenue = args?['eventVenue'] ?? '';
    return SingleChildScrollView(
      child: Material(
        color: Color(golden_yellow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                eventName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                organizer,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ticketDetailsWidget(
                      'First Name',
                      user["name"].toString() as String,
                      'UID',
                      user["uid"].toString()),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: ticketDetailsWidget(
                        'Last Name',
                        (user['sname'] ?? "").toString(),
                        'Course',
                        '${user["course"].toString()}'),
                  ),
                  SizedBox(height: 32.0),
                  DashedLine(),
                ],
              ),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.0, bottom: 10.0),
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                      child: Text(
                        'Date: $eventDate',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.0, bottom: 10.0),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                      child: Text(
                        'Time: $eventTime',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.0, bottom: 10.0),
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                      child: Text(
                        'Venue: $eventVenue',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'CONFIRMED',
                      style: TextStyle(
                          color: Colors.green[800],
                          fontSize: (30.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: TextStyle(color: Color(text_dm_offwhite)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: TextStyle(color: Color(text_dm_offwhite)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}

class DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final double dashWidth = 5.0;
    final double dashSpace = 5.0;

    double currentX = 0.0;
    final double endX = size.width;

    while (currentX < endX) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashWidth, 0.0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
