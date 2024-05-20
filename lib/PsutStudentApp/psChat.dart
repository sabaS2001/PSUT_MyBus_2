import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/model/message.dart';
import 'package:psut_my_bus/PsutStudentApp/psBottomNavBar.dart';

class PSChat extends StatefulWidget {
  String email;
  PSChat({super.key, required this.email});

  @override
  State<PSChat> createState() => _PSChatState(email: email);
}

class _PSChatState extends State<PSChat> {
  String email;
  _PSChatState({required this.email});

  final _firestore = FirebaseFirestore.instance;
  final TextEditingController message = TextEditingController();
  
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
                MaterialPageRoute(builder: (context) => const PSNavBar()),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height*.25 ,
                child: Messages(
                  email: email,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet'),
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[900],
                        hintText: 'Message',
                        hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet'),
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        _firestore.collection('Messages').doc().set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'email': email,
                        });

                        message.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
