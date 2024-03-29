import 'package:flutter/material.dart';
import 'package:runcool/pages/profileDependancies/profileList.dart';
import '../../utils/everythingUtils.dart';

import 'package:runcool/models/User.dart';
import 'package:provider/provider.dart';

class ProfileUI1 extends StatefulWidget {
  final AppUser user;
  final bool requested;
  ProfileUI1({@required this.user, this.requested});

  @override
  ProfileUI1State createState() => ProfileUI1State();
}

class ProfileUI1State extends State<ProfileUI1> {
  bool requested;

  ProfileUI1State({this.requested});

  _initReq() {
    requested = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    (requested) ?? _initReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppUser currUser = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: ProfileList(
          user: widget.user,
          currUserID: currUser.uid,
          requested: requested,
        ),
      ),
    );
  }
}
