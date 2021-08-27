
import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Constants/Styles.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subHeading;
  final bool isActive;
  final Function function;
  const HomeCard({
    Key key,
     this.icon,
     this.title,
     this.subHeading,
     this.isActive,
     this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: function(),
      child: Container(
        padding: EdgeInsets.all(10).copyWith(bottom: 0),
        decoration: BoxDecoration(
          boxShadow: [kCardShadow],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: isActive
                ? [
                    kPrimaryColor,
                    kPrimaryColor.withOpacity(0.7),
                  ]
                : [Colors.white, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 60,
              color: isActive ? Colors.white : kPrimaryColor,
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subHeading,
              style: TextStyle(
                color: isActive ? Colors.white70 : Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
