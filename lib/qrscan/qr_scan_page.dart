import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'button_widget.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = 'Unknown';

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text(MyApp.title),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Scan Result',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.indigo[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
               Text(
                'Tap on the link to open',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo[100],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      launch(qrCode);
                    },
                    child: Text(
                      '$qrCode',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[400],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              // ElevatedButton(onPressed: () => scanQRCode(), child: Text('Start'),),
              ButtonWidget(
                text: 'SCAN NOW',
                onClicked: () => scanQRCode(),
              ),
            ],
          ),
        ),
      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });

      //   var request = http.MultipartRequest(
      //       'POST', Uri.parse('localhost:8000/api/qr_code'));
      //   request.files.add(await http.MultipartFile.fromPath(
      //       'file', '/C:/Users/umar17605/AppData/Local/Temp/qr.pdf'));

      //   http.StreamedResponse response = await request.send();

      //   if (response.statusCode == 200) {
      //     print(await response.stream.bytesToString());
      //   } else {
      //     print(response.reasonPhrase);
      //   }

    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
