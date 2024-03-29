// Still in testing
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:runcool/controllers/NotificationManager.dart';
import 'package:runcool/pages/EventPageUI.dart';
import '../models/Event.dart';

class EventManager {
  CollectionReference events = FirebaseFirestore.instance.collection('events');

  createEvent(Map eventDetails) async {
    //Convert to Map<String, dynamic>
    Map<String, dynamic> data =
        eventDetails.map((key, value) => MapEntry(key.toString(), value));
    data['deleted'] = false;
    print(data['checkpoints']);
    print(data['checkpoints'].runtimeType);
    var docID = await events.add(data);
    DocumentSnapshot eventSnapshot = await docID.get();

    Event event = Event.createEventFromFirestore(eventSnapshot);

    return event;
  }

  Future joinEvent(String eventId, String uid) async {
    await events.doc(eventId).update({
      "participants": FieldValue.arrayUnion([uid]),
    });
  }

  Future quitEvent(String eventId, String uid) async {
    events.doc(eventId).update({
      "participants": FieldValue.arrayRemove([uid]),
    });
  }

  Future deleteEvent(event) async {
    await events.doc(event.eventID).delete();
    await NotificationManager().notifyEventUpdate(event, true);
  }

  List<Widget> getAnnouncements(List announcements) {
    // if announcements.isEmpty
    announcements.sort(
        (a, b) => b["timeStamp"].toDate().compareTo(a["timeStamp"].toDate()));
    return announcements.map((a) => Announcement(a)).toList();
  }

  Future addAnnouncement(
      {@required String message,
      @required String announcer,
      @required String eventID,
      @required String announcerID}) async {
    Map<String, dynamic> announcement = {};
    announcement["announcer"] = announcer;
    announcement["message"] = message;
    announcement["timeStamp"] = Timestamp.now();
    DocumentReference eventRef = events.doc(eventID);
    await eventRef.update({
      "announcements": FieldValue.arrayUnion([announcement]),
    });
    await NotificationManager().notifyAnnouncement(eventRef, announcerID);
  }
}
