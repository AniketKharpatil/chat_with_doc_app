// import 'package:eurpay_app/qr_scan/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
                  fontSize: 16,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$qrCode',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 72),
              // ElevatedButton(onPressed: () => scanQRCode(), child: Text('Start'),),
              ButtonWidget(
                text: 'QR Scan',
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

    
    }
    on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
