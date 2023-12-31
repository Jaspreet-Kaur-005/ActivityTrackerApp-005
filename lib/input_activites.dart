import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Daily Activities Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RecordActivitiesScreen(),
//     );
//   }
// }

class RecordActivitiesScreen extends StatefulWidget {
  @override
  _RecordActivitiesScreenState createState() => _RecordActivitiesScreenState();
}

class _RecordActivitiesScreenState extends State<RecordActivitiesScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

  List<ActivityRecord> activityRecords = [];
  int currentActivityIndex = 0;

  void recordActivity(ActivityRecord record) async {
    setState(() {
      activityRecords.add(record);
      currentActivityIndex++;
      if (currentActivityIndex >= 4) {
        currentActivityIndex = 0;
      }
    });

    try {
      // Get the current date
      DateTime now = DateTime.now();

      // Add the activity record to Firestore
      await activitiesCollection.add({
        'name': record.name,
        'scheduledTime': record.scheduledTime,
        'completionTime': record.completionTime,
        'score': record.score,
        'day': _getDayOfWeek(now.weekday),
        'date': now.toLocal().toString(),
      });
    } catch (e) {
      print('Error adding activity record to Firestore: $e');
    }
  }

  // function to get the day of the week as a string
  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  void navigateToPreviousActivity() {
    setState(() {
      if (currentActivityIndex > 0) {
        currentActivityIndex--;
      }
    });
  }

  void navigateToNextActivity() {
    setState(() {
      currentActivityIndex++;
      if (currentActivityIndex >= 4) {
        currentActivityIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Daily Activities Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ActivityInputCard(
                activityIndex: currentActivityIndex,
                onActivityRecorded: recordActivity,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.navigate_before),
                  onPressed: navigateToPreviousActivity,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: navigateToNextActivity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityInputCard extends StatefulWidget {
  final int activityIndex;
  final Function(ActivityRecord) onActivityRecorded;

  const ActivityInputCard({
    Key? key,
    required this.activityIndex,
    required this.onActivityRecorded,
  }) : super(key: key);

  @override
  _ActivityInputCardState createState() => _ActivityInputCardState();
}

class _ActivityInputCardState extends State<ActivityInputCard> {
  late TextEditingController nameController;
  late TextEditingController scheduledTimeController;
  late TextEditingController completionTimeController;
  late TextEditingController scoreController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    scheduledTimeController = TextEditingController();
    completionTimeController = TextEditingController();
    scoreController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity ${widget.activityIndex + 1} - Activity Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter activity name',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Scheduled Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: scheduledTimeController,
              decoration: InputDecoration(
                hintText: 'Enter scheduled time',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Completion Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: completionTimeController,
              decoration: InputDecoration(
                hintText: 'Enter completion time',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Efficiency Score (out of 10):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter efficiency score',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String scheduledTime = scheduledTimeController.text;
                String completionTime = completionTimeController.text;
                int score = int.tryParse(scoreController.text) ?? 0;

                if (name.isNotEmpty &&
                    scheduledTime.isNotEmpty &&
                    completionTime.isNotEmpty) {
                  // DateTime now = DateTime.now();
                  // DateTime recordTime = DateTime(
                  //   now.year,
                  //   now.month,
                  //   now.day,
                  //   now.hour,
                  //   now.minute,
                  // );

                  ActivityRecord record = ActivityRecord(
                      name, scheduledTime, completionTime, score);
                  widget.onActivityRecorded(record);

                  // Clear text fields
                  nameController.clear();
                  scheduledTimeController.clear();
                  completionTimeController.clear();
                  scoreController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Record Activity'),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityRecord {
  final String name;
  final String scheduledTime;
  final String completionTime;
  final int score;

  ActivityRecord(
      this.name, this.scheduledTime, this.completionTime, this.score);
}
