import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {

  @override
  State<ScheduleScreen> createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
   DateTime scheduledDate=DateTime.now();

  void _setSchedule(DateTime date) {

    setState(() {
      scheduledDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sharide'),
      ),
      body: Container(
          child: Column(
        children: [
          const Text('Select your ride schedule date and time:', style:  TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
          ElevatedButton(
            child: Text('Select date/time for your next ride'),
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                _setSchedule(date);
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
          ),
          Text('Selected date: ' + DateFormat.yMMMd().format(scheduledDate)),
          ElevatedButton(onPressed: (){}, child: Text('Confirm')),
        ],
      )),
    );
  }}