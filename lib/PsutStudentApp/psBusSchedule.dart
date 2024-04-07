import 'package:flutter/material.dart';
import 'psBottomNavBar.dart';

class PSBusSchedule extends StatelessWidget {
  const PSBusSchedule({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(80.0, 30.0, 50.0, 0.0),
          child: const Text(
            'Bus Schedule',
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Wellfleet',
              color: Colors.black,
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
    );
  }
}