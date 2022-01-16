import 'package:choicen_robot/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function deleteActivity;

  ActivityList(
    this.activities,
    this.deleteActivity,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      child: activities.isEmpty
          ? const Center(
              child: Text('Secenek Ekleyiniz'),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    title: Text('${activities[index].activityName}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteActivity(activities[index].activityId),
                    ),
                  ),
                );
              },
              itemCount: activities.length,
            ),
    );
  }
}
