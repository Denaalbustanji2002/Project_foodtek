import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/app_bar1.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
        appBar: CustomAppBar()

    );
  }
}
