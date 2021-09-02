import 'dart:ui';

import 'package:doc_app/BottomNavBar.dart';
import 'package:doc_app/Components/DoctorCard.dart';
import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Constants/DoctorList.dart';
import 'package:doc_app/Constants/Doubles.dart';
import 'package:flutter/material.dart';

import 'HomeCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white70,
              title: Text(
                'Aniket Kharpatil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_rounded,
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
            SliverPadding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.023),
              sliver: SliverGrid.count(
                crossAxisSpacing: MediaQuery.of(context).size.height * 0.025,
                crossAxisCount: 2,
                children: [
                  HomeCard(
                    icon: Icons.add_circle_rounded,
                    title: "Clinic Visit",
                    subHeading: "Make an appointment",
                    isActive: true,
                    function: () {},
                  ),
                  HomeCard(
                    icon: Icons.home_rounded,
                    title: "Home Visit",
                    subHeading: "Call the doctor home",
                    isActive: false,
                    function: () {},
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What are your symptoms?",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      // height: 15,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        // horizontal: 20,
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              spreadRadius: 0.6)
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              color: kPrimaryColor,
                              size: MediaQuery.of(context).size.height * 0.035,
                            ),
                            isDense: true,
                            counterText: "",
                            hintText: "Search",
                            contentPadding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.016),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: BorderSide.none)),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        maxLength: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverGrid.count(
                crossAxisSpacing: MediaQuery.of(context).size.height * 0.025,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.025,
                crossAxisCount: 2,
                children:
                    kDoctorList.map((e) => DoctorCard(doctor: e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
