import 'dart:io';
import 'package:doc_app/Screens/dochome.dart';
import 'package:doc_app/services/firestore_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as Path;
import 'package:flutter/services.dart';

class FormFour extends StatefulWidget {
  @override
  _FormFourState createState() => _FormFourState();
}

class _FormFourState extends State<FormFour> with Validator {
  File cert;
  File file;
  Future getFile() async {
    final fileResult = await FilePicker.platform.pickFiles();
    if (fileResult == null) return;
    final path = fileResult.files.single.path;
    setState(() {
      file = File(path);
    });
  }

  Future getCert() async {
    final fileResult = await FilePicker.platform.pickFiles();
    if (fileResult == null) return;
    final path = fileResult.files.single.path;
    setState(() {
      cert = File(path);
    });
  }
  // final snackBar = SnackBar();

  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final double minValue = 8.0;

  int experienceIndex = 0;

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  void initState() {
    _onCreated();
    super.initState();
  }

  void _onCreated() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  String name, description, email, mobile, specialization, exp, college;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user1 = FirebaseAuth.instance.currentUser;
  final _storage = Path.FirebaseStorage.instance;

  final Color activeColor = Colors.black;
  final Color inActiveColor = Colors.white;

  void updateData() async {
    await db.collection('doctors_data').doc(user1.uid).set({
      'name': name,
      'email': email,
      'uid': user1.uid,
      'role': 'doctor',
      'status': 'unavailable',
      'college': college,
      'experience': exp,
      'specialization': specialization,
      'certificate': cert?.path.toString()
    });
  }

  showError() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ERROR'),
        content: Text("Please upload certificate and Profile Image"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final filepath = cert?.path;
      final filepath2 = file?.path;

      FirebaseUplaodNewFile.uploadFile("certif", cert);

      setState(() {});
      updateData();

      FirebaseUplaodNewFile.uploadFile("profile", file);
      if (cert.path == null || file.path == null) {
        showError();
      } else
        showstat();

      /////////////////////adding data to database "doctors"///////////////////////////////
      // DocumentReference ref = await db.collection('doctors_data').add({
      //   'name': name,
      //   'desc': description,
      //   'email': email,
      //   'college': college,
      //   'experience': exp,
      //   'specialization': specialization,
      //   'certificate': cert?.path.toString()
      // });
      // setState(() => id = ref.id);
      // print(ref.id);
      // showstat();

      // DocumentReference ref = await db.collection('doctors_data').doc(id).add({
      //   'name': name,
      //   'desc': description,
      //   'email': email,
      //   'college': college,
      //   'experience': exp,
      //   'specialization': specialization,
      //   'certificate': cert?.path.toString()
      // });
      // setState(() => id = ref.id);
      // print(ref.id);
      // showstat();

      // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  void showstat() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Successful'),
        content: Text("submitted"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage2()),
              );
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _nameController,
        validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff7266d8), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "Full Name",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => name = value,
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.text,
          validator: validateEmail,
          onChanged: (String value) {},
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff7266d8), width: 0.7),
              ),
              border: const OutlineInputBorder(),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.grey[600])),
          onSaved: (value) => email = value,
        ));
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _specializationController,
        keyboardType: TextInputType.text,
        // maxLines: 2,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff7266d8), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "Specialization",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => specialization = value,
      ),
    );
  }

  Widget _buildExp() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _expController,
        keyboardType: TextInputType.text,
        // maxLines: 2,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff7266d8), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "Years of Experience",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => exp = value,
      ),
    );
  }

  Widget _buildCollege() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _collegeController,
        keyboardType: TextInputType.text,
        // maxLines: 2,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff7266d8), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "Medical College Name",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => college = value,
      ),
    );
  }

  Widget _buildPhone() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _phoneController,

        validator: mobileValidator,
        keyboardType: TextInputType.text,
        // maxLines: 2,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff7266d8), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "Mobile Number",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => mobile = value,
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: 260,
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [Colors.blue, Color(0xff7266d8)])),
      child: RaisedButton(
        onPressed: createData,
        padding: EdgeInsets.symmetric(vertical: minValue * 2.4),
        elevation: 0.0,
        color: Colors.transparent,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Doctor Form"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      //child: Column(children:<Widget>[_buildName(),_buildEmail(),_buildDescription(),], ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0).copyWith(top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: minValue * 1,
                              ),
                              file?.path == null
                                  ? GestureDetector(
                                      onTap: getFile,
                                      child: Container(
                                        child: CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: AssetImage(
                                              "assets/images/profile.png"),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: getFile,
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage:
                                            FileImage(File(file.path)),
                                      ),
                                    ),
                              //  Container(
                              //   height: 140,
                              //   width: 140,
                              //     decoration: new BoxDecoration(
                              //       color: Colors.teal,
                              //       // shape: BoxShape.circle,
                              //      borderRadius: BorderRadius.all(Radius.circular(70.0))
                              //       // borderRadius: BorderRadius.circular(40),

                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Center(
                              //         child: Image.file(
                              //         File(file?.path),
                              //         fit: BoxFit.contain,
                              //         // height: 150,
                              //         // width: 150,
                              //         ),
                              //       ),
                              //     )

                              //   ),

                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildName(),
                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildEmail(),
                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildPhone(),
                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildCollege(),
                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildExp(),
                              SizedBox(
                                height: minValue * 1,
                              ),
                              _buildDescription(),
                              Text(
                                  "Degree Certificate or relevant informative file"),
                              TextButton(
                                  onPressed: getCert, child: Text("Add file")),
                              Text(cert?.path.toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: minValue * 2,
                    ),
                    _buildSubmitBtn(),
                    SizedBox(
                      height: minValue * 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Validator {
  static bool isEmail(String email) => EmailValidator.validate(email);

// Making Form Email Validation
  String validateEmail(String value) {
    bool isEmail(String email) => EmailValidator.validate(email);
    String msg = '';
    if (!isEmail(value.trim())) {
      msg = 'Please enter a valid email';
    } else {
      msg = null;
    }
    return msg;
  }

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be 4';
    }
  }

  String mobileValidator(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }
}

// class MyComponentsLoader extends StatelessWidget {
//   final Color color;
//
//   MyComponentsLoader({this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return CircularProgressIndicator();
//   }
// }