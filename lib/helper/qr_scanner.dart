import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool scanned = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getStudentNumber() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var sharedPrefstudentNumber = sharedPreferences.getString('student number');
    return sharedPrefstudentNumber!;
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(AppLocalizations.of(context)!.resultText + result!.code)
                  else
                    Text(AppLocalizations.of(context)!.scanCodeText),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.black,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    String studentNumber = await getStudentNumber();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      if (scanData.code.toString().contains('workplace')) {
        int workplaceId = -1, machineId = -1;
        List<String> split = scanData.code.toString().split(' ');
        List<String> splitWorkplace = split[0].split('=');
        List<String> splitMachine = split[0].split('=');
        workplaceId = int.parse(splitWorkplace[1]);
        if (scanData.code.toString().contains('machine')) {
          print('result contains machine');
          machineId = int.parse(splitMachine[1]);
          Navigator.pushNamed(context, '/safety_instructions', arguments: {
            'workplaceId': workplaceId,
            'machineId': machineId
          }).then((value) => controller.resumeCamera());
        } else {
          Map<String, Object> data = new HashMap<String, Object>();
          data.putIfAbsent('student number', () => studentNumber);
          data.putIfAbsent('workplace_id', () => workplaceId);
          data.putIfAbsent('date', () => DateTime.now());

          await firestore.collection('Logs').add(data);
          Navigator.pushNamed(context, '/machines',
                  arguments: {'workplaceId': workplaceId})
              .then((value) => controller.resumeCamera());
        }
      }
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
