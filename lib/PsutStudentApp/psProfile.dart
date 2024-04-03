import 'package:flutter/material.dart';
import 'psSettings.dart';

class PSProfile extends StatelessWidget {
  const PSProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PSSettings()),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text('Profile',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 30.0,
                  )),
            ),
            const SizedBox(height: 20.0,),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
              radius: 80.0,
            ),
            const SizedBox(height: 40.0,),
            Column(
              children: [
                SizedBox(
                  width: 340.0,
                  height: 40.0,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.black)
                        ),
                        labelText: "First Name:",
                        labelStyle: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                SizedBox(
                  width: 340.0,
                  height: 40.0,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.black)
                        ),
                        labelText: "Last Name:",
                        labelStyle: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                SizedBox(
                  width: 340.0,
                  height: 40.0,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.black)
                        ),
                        labelText: "Student ID:",
                        labelStyle: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                SizedBox(
                  width: 340.0,
                  height: 40.0,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:const BorderSide(color: Colors.black)
                        ),
                        labelText: "Student Email:",
                        labelStyle: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                SizedBox(
                  width: 340.0,
                  height: 40.0,
                  child: TextField(
                    cursorColor: Colors.redAccent,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(width: 5.0, color: Colors.black)
                        ),
                        labelText: "Bus Line (Read-Only):",
                        labelStyle: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height:70.0),
                SizedBox(
                  width: 310.0,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PSSettings()),
                        );
                      },
                      child: const Text('Save',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 169, 224, 1.0),
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                          )),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width:1.8,color: Color.fromRGBO(0, 24, 113, 1.0)),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}