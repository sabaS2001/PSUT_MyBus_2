import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/psHome.dart';
class PSChat extends StatelessWidget {
  const PSChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0.0, 30.0, 20.0, 0.0),
            child: const Text(
              'PSUT Bus Administrator',
              style: TextStyle(
                fontSize: 16.0,
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
                MaterialPageRoute(builder: (context) => const PSHomePage()),
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
