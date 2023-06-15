import 'package:calendarwithbackend/schedule.dart';
import 'package:calendarwithbackend/showupcomingschedule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';



class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}


class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    // initializeFirebase(); // Initialize Firebase in the initState
  }



  final _calendarControllerToday = AdvancedCalendarController.today();
  final events = <DateTime>[
    DateTime.now(),
  ];
  Query dbRef = FirebaseDatabase.instance.ref().child('Lawyers');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Lawyers');

  Widget listItem({required Map student}) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(12),
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFC99F4A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            // : Alignment.centerLeft,
            // textAlign: TextAlign.left,
            student['name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFC99F4A)),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15,),
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
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(child: const Text('Calendar')),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // for the searching
            SizedBox(height: 1,),

            //for the search bar and search button
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 70, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for a meeting',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle search button click
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xDECEB300),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //for the calendar
            Container(
              height: 270,
              child: AdvancedCalendar(
                controller: _calendarControllerToday,
                events: events,
                startWeekDay: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Task Overview',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 05,),

            //Task overview container with the row which also contain the container
            Container(
              height: 160,
              child: Row(
                // crossAxisCount: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Container(
                      height: 190,
                      width: 110,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC99F4A),width: 2.0),
                      ),

                      child: Transform.translate(
                        offset: const Offset(0, 20), // Shift the text down by 10 pixels
                        child: const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 190,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC99F4A),width: 2.0),
                      ),
                      child: Transform.translate(
                        offset: const Offset(0, 20), // Shift the text down by 10 pixels
                        child: const Text(
                          'Left',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 210,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC99F4A),width: 2.0),
                      ),
                      child: Transform.translate(
                        offset: const Offset(0, 20), // Shift the text down by 10 pixels
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            //   Schedule text and the container(which contain the name and day)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 190),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,CupertinoPageRoute(builder: (context)=> const Schedule()));

                    },
                    child:  Text(
                      'SEE ALL',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.combine([
                          TextDecoration.underline,

                        ]),
                        color: Color(0xFFC99F4A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // child: Container(
              //   height: 100,
              //   child: Row(
              //     // crossAxisCount: 3,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           height: 80,
              //           width: 220,
              //           decoration: BoxDecoration(
              //
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: const Color(0xFFC99F4A),width: 2.0)
              //             ,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           height: 80,
              //           width: 220,
              //           decoration: BoxDecoration(
              //
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: const Color(0xFFC99F4A),width: 2.0)
              //             ,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           height: 80,
              //           width: 220,
              //           decoration: BoxDecoration(
              //
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: const Color(0xFFC99F4A),width: 2.0)
              //             ,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              child: Container(
                // height: double.infinity,

                height: 100,
                width: 600,
                // child: FirebaseAnimatedList(
                //   scrollDirection: Axis.horizontal,
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
                child: FirebaseAnimatedList(
                  scrollDirection: Axis.horizontal,
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
            ),

            SizedBox(height: 15,),

            //schedule upcoming content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Schedule Upcoming',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 70),
                  GestureDetector(
                    onTap: () {
                      // Handle button click here
                      Navigator.push(context,CupertinoPageRoute(builder: (context)=> const Addschedule()));
                    },
                    child:  Text(
                      'SEE ALL',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.combine([
                          TextDecoration.underline,

                        ]),
                        color: Color(0xDECEB300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 100,
                width: 600,
                child: FirebaseAnimatedList(
                  scrollDirection: Axis.horizontal,
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
                    if (currentDateString != fetchedDateString) {
                      return listItem(student: student);
                    } else {
                      return Container(); // Return an empty container if the dates don't match
                    }
                  },
                ),
              ),
            ),


            SizedBox(height: 05,),
            SizedBox(height: 05,),
            // Container(
            //   height: 120,
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.yellow,
            //
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.blue,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 420,
            //   // color: Colors.yellow,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.yellow,
            //
            //         ),
            //
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.yellow,
            //
            //         ),
            //
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.yellow,
            //
            //         ),
            //
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 40,
            //           color: Colors.yellow,
            //
            //         ),
            //
            //       ),
            //     ],
            //   ),
            //
            // )
            // Container(
            //   height: 60,
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     children: [
            //       Container(
            //         color: Colors.yellow,
            //       ),
            //       Container(
            //         color: Colors.blue,
            //       ),
            //       Container(
            //         color: Colors.black,
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     children: [
            //       Container(
            //         color: Colors.yellow,
            //       ),
            //       Container(
            //         color: Colors.blue,
            //       ),
            //       Container(
            //         color: Colors.black,
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     children: [
            //       Container(
            //         color: Colors.yellow,
            //       ),
            //       Container(
            //         color: Colors.blue,
            //       ),
            //       Container(
            //         color: Colors.black,
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     children: [
            //       Container(
            //         color: Colors.yellow,
            //       ),
            //       Container(
            //         color: Colors.blue,
            //       ),
            //       Container(
            //         color: Colors.black,
            //       ),
            //     ],
            //   ),
            // ),
            // Add more containers, texts, or widgets here
          ],
        ),
      ),
    );
  }
}