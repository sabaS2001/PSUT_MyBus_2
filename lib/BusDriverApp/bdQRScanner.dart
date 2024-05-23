import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psut_my_bus/BusDriverApp/bdStudentList.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:typed_data';

MobileScannerController cameraController = MobileScannerController();

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    super.key,
    required this.value,
    required this.screenClosed,
  });

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined,),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Scanned Code:", style: TextStyle(fontSize: 20,),),
              const SizedBox(height: 20,),
              Text(widget.value, style: const TextStyle(fontSize: 16,),),
            ],
          ),
        ),
      ),
    );
  }
}

class BDQRScan extends StatefulWidget {
  const BDQRScan({super.key, required});

  @override
  State<BDQRScan> createState() => _BDQRScanState();
}



class _BDQRScanState extends State<BDQRScan> {
  late var qrInfo = [];
  late List<String> scannedData;

  Future<void> addStudent(String name, String studentID, String image) async {
    FirebaseFirestore.instance.collection('StudentListQR').add({
      'name': name,
      'studentID': studentID,
      'imageLink': image
      // add more fields as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 30.0, 30.0, 0.0),
          child: const Center(
            child: Text(
              'QR Code Scanner',
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Wellfleet',
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BDStudentList(id: qrInfo[2] ?? '', name: qrInfo[0] + ' ' + qrInfo[1] ?? '', profileImage: qrInfo[3] ?? '')),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0, // specify your desired width
              height: 300.0, // specify your desired height
              child: MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;
                  for (final barcode in barcodes) {
                    debugPrint('QR Code Found! ${barcode.rawValue}');
                    qrInfo = (barcode.rawValue)!.split(' ');
                    if(barcode.rawValue != null){
                      addStudent(qrInfo[0] + ' ' + qrInfo[1], qrInfo[2], qrInfo[3]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BDStudentList(id: qrInfo[2] ?? '', name: qrInfo[0] + ' ' + qrInfo[1] ?? '', profileImage: qrInfo[3] ?? '')),
                      );
                    }
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.black,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return const Icon(
                              Icons.flash_off, color: Colors.grey);
                        case TorchState.on:
                          return const Icon(
                              Icons.flash_on, color: Colors.yellow);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
                IconButton(
                  color: Colors.black,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state) {
                        case CameraFacing.front:
                          return const Icon(Icons.camera_front);
                        case CameraFacing.back:
                          return const Icon(Icons.camera_rear);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.switchCamera(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

