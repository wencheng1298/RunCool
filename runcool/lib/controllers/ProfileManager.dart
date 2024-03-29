import 'AuthenticationManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProfileManager {
  final String uid;
  String newuid;

  ProfileManager({this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  AuthenticationManager authManager = AuthenticationManager();

  updateProfile(Map profileDetails) {
    Map<String, dynamic> data =
        profileDetails.map((key, value) => MapEntry(key.toString(), value));
    users.add(data);
  }

  Future<String> createUser(
      Map profileDetails, String email, String password) async {
    try {
      dynamic user =
          await authManager.registerWithEmailAndPassword(email, password);

      Map<String, dynamic> data =
          profileDetails.map((key, value) => MapEntry(key.toString(), value));
      data['notifications'] = [];
      data['events'] = [];
      data['friends'] = [];
      data['email'] = user.email;

      await users.doc(user.uid).set(data);
      return "success";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Stream<AppUser> getUserFromID(docID) {
  //   return users
  //       .doc(docID)
  //       .snapshots()
  //       .map((doc) => AppUser.fromFirestore(doc));
  // }

  // Stream<AppUser> getCurrentUserObject() {
  //   User currUser = authManager.getCurrUserFromFirebase();
  //
  //   return (currUser == null) ? null : getUserFromID(currUser.uid);
  // }

  Future uploadPic(File image) async {
    String fileName = basename(image.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    // TaskSnapshot taskSnapshot = uploadTask.snapshot;
    await Future.value(uploadTask);
    final link = await ref.getDownloadURL();
    return link;
  }
  // https://www.youtube.com/watch?v=7uqmY6le4xk

}
