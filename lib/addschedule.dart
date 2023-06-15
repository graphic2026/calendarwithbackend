import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _InsertDataState();
}

class _InsertDataState extends State<AddSchedule> {

  final  userNameController = TextEditingController();
  // final  userAgeController= TextEditingController();
  // final  userSalaryController =TextEditingController();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  // DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    // initializeFirebase();
    dbRef = FirebaseDatabase.instance.ref().child('Lawyers');
    // dbRef= FirebaseDatabase.instance.ref().child('Students1');
  }
  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime.format(context);
      });
    }
  }
  // Future<void> initializeFirebase() async {
  //   try {
  //     await Firebase.initializeApp();
  //     print('hello1');
  //   } catch (e) {
  //     print('Failed to initialize Firebase: $e');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserting data'),
      ),
      body: ListView(
        children:[ Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Add Schedule',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // TextField(
                //   controller: userAgeController,
                //   keyboardType: TextInputType.number,
                //   decoration: const InputDecoration(
                //
                //     border: OutlineInputBorder(),
                //     labelText: 'Day & Time',
                //     hintText: 'Enter Day & time',
                //   ),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // TextField(
                //   controller: userSalaryController,
                //   keyboardType: TextInputType.phone,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Salary',
                //     hintText: 'Enter Your Salary',
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    hintText: 'Select a date',

                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _timeController,
                  readOnly: true,
                  onTap: () => _selectTime(context),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time',
                    hintText: 'Select a time',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(

                  onPressed: () {
                    // if (userAgeController.text == "25") {
                      Map<String, String> lawyers = {
                        'name': userNameController.text,
                        'date': _dateController.text,
                        'time': _timeController.text

                      };

                      dbRef.push().set(lawyers);
                      print('hello3');
                    // }
                    // else{
                    //   Map<String,String> students1={
                    //     'name': userNameController.text,
                    //     'age' : userAgeController.text,
                    //     'salary': userSalaryController.text,
                    //   };
                    //   dbRef.push().set(students1);
                    //   print('hello2');
                    //
                    // }
                  }
                  ,

                  child: const Text('Add'),
                  color: Color(0xFFC99F4A),
                  textColor: Colors.white,
                  minWidth: 200,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
       ]
      ),
    );
  }
}