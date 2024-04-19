import 'package:flutter/material.dart';
import 'psBottomNavBar.dart';
import 'package:qr_flutter/qr_flutter.dart';
class PSQRCode extends StatelessWidget {
  const PSQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 30.0, 30.0, 0.0),
          child: const Center(
            child: Text(
              'QR Code',
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
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PSNavBar()),
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
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'), // to be changed to users profile picture
                backgroundColor: Colors.transparent,
                radius: 80.0,
              ),
              const SizedBox(height: 10.0),
              QrImageView(
                data: 'https://www.psut.edu.jo/', //userName+uniID+busLine+Image to use later as variables for qr data
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          )
      ),

    );
  }

}