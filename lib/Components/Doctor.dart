import 'package:flutter/cupertino.dart';

class Doctor {
  final String name;
  final String profession;
  final double rating;
  final String urlToImage;
  final double phNo;
  final String aboutMe;
  final String location;
  final double price;

  Doctor(
      {@required this.phNo,
      @required this.aboutMe,
      @required this.location,
      @required this.price,
      @required this.name,
      @required this.profession,
      @required this.rating,
      @required this.urlToImage});
}
