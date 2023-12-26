import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/

class StarredMessagesPage extends StatelessWidget {
  const StarredMessagesPage({Key? key}) : super(key: key);
//This is a Dummy Starred Message
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starred Messages'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://placeimg.com/200/200/people'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sender Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Starred message content...',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'File 1: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: 'dummyfile1.pdf',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          // Handle file preview tap
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Image.network(
                  'https://placeimg.com/200/200/files',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            trailing: Icon(Icons.star, color: Colors.yellow),
            onTap: () {
              // Handle tapped message
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://placeimg.com/200/200/people'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sender Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Starred message content...',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'File 2: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: 'dummyfile2.docx',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          // Handle file preview tap
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Image.network(
                  'https://placeimg.com/200/200/images',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            trailing: Icon(Icons.star, color: Colors.yellow),
            onTap: () {
              // Handle tapped message
            },
          ),
          // Add more ListTile widgets for each starred message
        ],
      ),
    );
  }
}
