import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../utils/everythingUtils.dart';
import '../EventPageUI.dart';
import './../../models/User.dart';

class EventsForYouList extends StatefulWidget {
  @override
  _EventsForYouListState createState() => _EventsForYouListState();
}

class _EventsForYouListState extends State<EventsForYouList> {
  void goEventPage(event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventPage(
                  eventID: event.eventID,
                )));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> eventWidget = [];
    final List<dynamic> eventsForYou =
        Provider.of<List<dynamic>>(context) ?? [];
    final user = Provider.of<AppUser>(context);

    eventsForYou.forEach((element) {
      if (element.startTime != null &&
          element.startTime.isAfter(DateTime.now()) && (element.creator != user.uid)) {
        eventWidget
            .add(EventCard(event: element, fn: () => goEventPage(element)));
      }
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: eventWidget,
    );
  }
}
