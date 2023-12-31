import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityDetailsScreen extends StatefulWidget {
  @override
  _ActivityDetailsScreenState createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Activity Details(Per Day)'),
      ),
      body: FutureBuilder(
        future: fetchActivityDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Map<String, dynamic>> fetchedData =
              snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: fetchedData.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> activityDetails = fetchedData[index];

              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(
                    'Activity: ${activityDetails['name']}',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Score: ${activityDetails['score']}'),
                      Text(
                          'Scheduled Time: ${activityDetails['scheduledTime']}'),
                      Text(
                          'Completion Time: ${activityDetails['completionTime']}'),
                      Text('Date: ${activityDetails['date']}'),
                      Text(
                        'Day: ${activityDetails['day']}',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchActivityDetails() async {
    QuerySnapshot snapshot =
        await activitiesCollection.orderBy('date', descending: true).get();
    List<Map<String, dynamic>> activityDetailsList = [];

    snapshot.docs.forEach((doc) {
      String activityName = doc['name'];
      int score = doc['score'];
      String scheduledTime = doc['scheduledTime'];
      String completionTime = doc['completionTime'];
      String date = doc['date'];
      String day = doc['day'];

      Map<String, dynamic> activityDetails = {
        'name': activityName,
        'score': score,
        'scheduledTime': scheduledTime,
        'completionTime': completionTime,
        'date': date,
        'day': day,
      };

      activityDetailsList.add(activityDetails);
    });

    return activityDetailsList;
  }
}
