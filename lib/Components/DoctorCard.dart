import 'package:doc_app/Constants/Styles.dart';
import 'package:doc_app/Components/Doctor.dart';
import 'package:doc_app/Screens/DoctorPage/DoctorPage.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({
    Key key,
   this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => DoctorPage(
              doctor: doctor,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(0).copyWith(left: 5,right: 5),
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [kCardShadow],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(doctor.urlToImage),
            ),
            Spacer(),
            Text(
              doctor.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              doctor.profession,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
