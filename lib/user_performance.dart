import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'acitivity_details.dart';
import 'input_activites.dart';
import 'profile_screen.dart';

class PerformanceSummaryScreen extends StatefulWidget {
  @override
  State<PerformanceSummaryScreen> createState() =>
      _PerformanceSummaryScreenState();
}

class _PerformanceSummaryScreenState extends State<PerformanceSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Activity Tracker App'),
      ),
      body: PerformanceSummaryBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.purple,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda_outlined),
            label: 'Details(per day)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to HomeScreen (current screen)
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecordActivitiesScreen()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityDetailsScreen()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
              break;
          }
        },
      ),
    );
  }
}

class PerformanceSummaryBody extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchWeeklyPerformanceData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // the value is a list of scores for each day of the week
        Map<String, List<int>> fetchedData =
            snapshot.data as Map<String, List<int>>;

        // Calculate average scores for each activity
        Map<String, double> averageScores = {};
        fetchedData.forEach((activity, scores) {
          double averageScore = scores.isNotEmpty
              ? scores.reduce((value, element) => value + element) /
                  scores.length
              : 0.0;
          averageScores[activity] = averageScore;
        });

        return ListView.builder(
          itemCount: averageScores.length,
          itemBuilder: (context, index) {
            String activity = averageScores.keys.elementAt(index);
            double averageScore = averageScores[activity] ?? 0.0;

            return Card(
              elevation: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text('$activity'),
                subtitle:
                    Text('Average Score: ${averageScore.toStringAsFixed(2)}'),
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, List<int>>> fetchWeeklyPerformanceData() async {
    QuerySnapshot snapshot = await activitiesCollection.get();
    Map<String, List<int>> weeklyPerformanceData = {};

    snapshot.docs.forEach((doc) {
      String activity = doc['name'];
      int score = doc['score'];
      String day = doc['day'];

      if (!weeklyPerformanceData.containsKey(activity)) {
        weeklyPerformanceData[activity] = [
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]; // Initialize with zeros for each day
      }

      int dayIndex = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ].indexOf(day);

      if (dayIndex != -1) {
        weeklyPerformanceData[activity]?[dayIndex] += score;
      }
    });

    return weeklyPerformanceData;
  }
}
