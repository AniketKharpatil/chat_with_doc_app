import 'package:doc_app/Constants/Styles.dart';
// import 'package:dr_doc/Constants/Styles.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget widget;
  const InfoCard({
    Key key,
     this.title,
     this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kHeadTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          widget
        ],
      ),
    );
  }
}
