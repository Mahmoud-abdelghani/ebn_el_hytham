import 'package:ebn_el_hytham/features/timetable/data/models/task_model.dart';

class TimeTableModel {
  final String day;
  final List<TaskModel> lectures;
  TimeTableModel({required this.day, required this.lectures});
}

List<TimeTableModel> timeTableData = [
  TimeTableModel(
    day: 'Saturday',
    lectures: [], // إجازة
  ),
  TimeTableModel(
    day: 'Sunday',
    lectures: [
      TaskModel(
        title: 'Digital Communications',
        location: 'Hall 2',
        time: '08:30am - 10:10am',
        fatra: 'فترة أولى',
      ),
      TaskModel(
        title: 'Microprocessors',
        location: 'Lab 4',
        time: '10:20am - 12:10pm',
        fatra: 'فترة تانية',
      ),
    ],
  ),
  TimeTableModel(
    day: 'Monday',
    lectures: [
      TaskModel(
        title: 'Mathematics',
        location: 'Room 101',
        time: '10:20am - 12:10pm',
        fatra: 'فترة تانيه',
      ),
    ],
  ),
  TimeTableModel(
    day: 'Tuesday',
    lectures: [], // إجازة
  ),
  TimeTableModel(
    day: 'Wednesday',
    lectures: [
      TaskModel(
        title: 'Control Systems',
        location: 'Hall 1',
        time: '12:20pm - 02:10pm',
        fatra: 'فترة تالته',
      ),
      TaskModel(
        title: 'Embedded Systems',
        location: 'Lab 1',
        time: '02:20pm - 04:10pm',
        fatra: 'فترة رابعه',
      ),
    ],
  ),
  TimeTableModel(
    day: 'Thursday',
    lectures: [
      TaskModel(
        title: 'Antennas',
        location: 'Room 305',
        time: '08:30am - 10:10am',
        fatra: 'فترة أولى',
      ),
    ],
  ),
  TimeTableModel(
    day: 'Friday',
    lectures: [], // إجازة
  ),
];