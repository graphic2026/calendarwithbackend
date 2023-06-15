import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addschedule.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {



  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  void initState() {
    super.initState();
    // initializeFirebase(); // Initialize Firebase in the initState
  }

  // Future<void> initializeFirebase() async {
  //   try {
  //     await Firebase.initializeApp();
  //     print('hello1');
  //   } catch (e) {
  //     print('Failed to initialize Firebase: $e');
  //   }
  // }


  // Query dbRef = FirebaseDatabase.instance.ref().child('Students');
  // DatabaseReference reference = FirebaseDatabase.instance.ref().child('Students');
  Query dbRef = FirebaseDatabase.instance.ref().child('Lawyers');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Lawyers');

  Widget listItem({required Map student}) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFC99F4A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children:[
          Text(
            student['name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Color(0xFFC99F4A)),
          ),
          const SizedBox(
            height: 5,
          ),

          Row(
            children: [
              SizedBox(width: 10,),
              Text(
                student['date'],
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400,),
              ),
              SizedBox(width: 5,),
              Text(

                student['time'],
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ],
          ),
              // const SizedBox(
              //   width: 5,
              // ),

      ]
          ),
          const SizedBox(
            width: 175,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            // verticalDirection: VerticalDirection.up,
            children: [
              GestureDetector(
                onTap: () {
                  reference.child(student['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Color(0xFFC99F4A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.all(10),
    //   padding: const EdgeInsets.all(14),
    //   height: 120,
    //   color: Colors.yellow,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         student['name'],
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //       ),
    //       const SizedBox(
    //         height: 5,
    //       ),
    //       Text(
    //         student['age'],
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //       ),
    //       const SizedBox(
    //         height: 5,
    //       ),
    //       // Text(
    //       //   student['salary'],
    //       //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //       // ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               // Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
    //             },
    //             child: Row(
    //               children: [
    //                 Icon(
    //                   Icons.edit,
    //                   color: Theme.of(context).primaryColor,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 6,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               reference.child(student['key']).remove();
    //             },
    //             child: Row(
    //               children: [
    //                 Icon(
    //                   Icons.delete,
    //                   color: Colors.red[700],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20,),
        Container(
        // height: double.infinity,

          height: 600,
        //normal fetching data function without any condition

        // width: 100,
        // child: FirebaseAnimatedList(
        //   query: dbRef,
        //   itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        //
        //     Map student = snapshot.value as Map;
        //     student['key'] = snapshot.key;
        //
        //     return listItem(student: student);
        //
        //   },
        // ),


        //  now apply the condition on the fetching data from the  database with compare with the current date
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map student = snapshot.value as Map;
              student['key'] = snapshot.key;

              // Get the fetched date from the student map
              String fetchedDate = student['date'];

              // Parse the fetched date string into a DateTime object
              DateTime fetchedDateTime = DateTime.parse(fetchedDate);

              // Get the current date
              DateTime currentDate = DateTime.now();

              // Format the current date and fetched date as strings
              String currentDateString = DateFormat('yyyy-MM-dd').format(currentDate);
              String fetchedDateString = DateFormat('yyyy-MM-dd').format(fetchedDateTime);

              // Compare the dates
              if (currentDateString == fetchedDateString) {
                // student['date'] = 'Today';
                return listItem(student: student);
              } else {
                return Container(); // Return an empty container if the dates don't match
              }
            },
          ),


        ),

          Container(
            margin: const EdgeInsets.fromLTRB(60, 60, 70, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,CupertinoPageRoute(builder: (context)=> const AddSchedule()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFC99F4A), // Background color
              ),
              child: const Text(
                'Add Schedule',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )

        ],

        ),
      // ),

    );
  }
}
