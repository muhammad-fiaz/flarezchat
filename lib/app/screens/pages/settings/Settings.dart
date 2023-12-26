import 'package:flutter/material.dart';

import 'Chats/ChatPage.dart';

/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 4,
              color: Colors.grey[300],
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/jack.png'),
              ),
              title: Text(
                'John Doe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                child: IconButton(
                  icon: Icon(Icons.qr_code),
                  color: Colors.black,
                  onPressed: () {
                    // Implement QR code functionality
                  },
                ),
              ),
              subtitle: Text(
                'Software Developer',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              subtitle: Text('Manage your account settings'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy'),
              subtitle: Text('Manage your privacy settings'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chats'),
              subtitle: Text('Manage your chat settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


