import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          const Center(
            child: Icon(
              Icons.notification_important,
              size: 200,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'notification'.toUpperCase()
          )
        ],
      )
    );
  }
}
