import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Constants/Doubles.dart';
import 'package:doc_app/Constants/Styles.dart';
import 'package:doc_app/Components/Doctor.dart';
import 'package:doc_app/Screens/DoctorPage/Delegate.dart';
import 'package:doc_app/Screens/DoctorPage/InfoCard.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorPage({Key key,  @required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: Delegate(doctor),
                ),
                SliverPadding(
                  padding: padding,
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoCard(
                          title: "About Doctor",
                          widget: Text(
                            doctor?.aboutMe,
                            style: kSubHeadTextStyle,
                          ),
                        ),
                        InfoCard(
                          title: "Reviews",
                          widget: Container(
                            height: 80,
                            child: PageView(
                              controller: PageController(
                                viewportFraction: 0.8,
                                initialPage: 0,
                              ),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  color: Colors.red,
                                ),
                                Container(
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InfoCard(
                          title: "Location",
                          widget: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city_rounded,
                                  color: kPrimaryColor,
                                  size: 40,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    doctor.location,
                                    style: kSubHeadTextStyle,
                                  ),
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: kPrimaryColor,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                        InfoCard(
                          title: "Consultation Price",
                          widget: Text(
                            "INR ${doctor.price}",
                            style: kSubHeadTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: kHeadTextStyle.copyWith(
                        color: Colors.white, fontSize: 20),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
