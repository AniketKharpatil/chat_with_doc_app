import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Components/Doctor.dart';
import 'package:doc_app/Screens/DoctorPage/ActionButton.dart';
import 'package:flutter/material.dart';

class Delegate extends SliverPersistentHeaderDelegate {
  final Doctor doctor;

  Delegate(this.doctor);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            20,
          ),
        ),
        color: kPrimaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(doctor.urlToImage),
            radius: 70,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            doctor.name,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            doctor.profession,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(
                iconData: Icons.call_rounded,
                function: () {},
              ),
              SizedBox(
                width: 20,
              ),
              ActionButton(
                iconData: Icons.messenger_rounded,
                function: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 300;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
