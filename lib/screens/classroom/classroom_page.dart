import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class ClassroomPage extends StatelessWidget {
  final String conferenceID;
  final String username;
  final String userID;

  const ClassroomPage({
    super.key,
    required this.conferenceID,
    required this.username,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appId,
        appSign: appSign,
        userID: userID,
        userName: username,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
