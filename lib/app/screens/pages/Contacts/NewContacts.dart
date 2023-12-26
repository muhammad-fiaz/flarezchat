import 'package:flutter/material.dart';
/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/

class NewContactPage extends StatelessWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search icon functionality
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Invite a Friend'),
                value: 'invite',
              ),
              PopupMenuItem(
                child: Text('Contacts'),
                value: 'contacts',
              ),
              PopupMenuItem(
                child: Text('Refresh'),
                value: 'refresh',
              ),
              PopupMenuItem(
                child: Text('Help'),
                value: 'help',
              ),
            ],
            onSelected: (value) {
              // Handle dropdown menu item selection
              if (value == 'invite') {
                // Implement invite functionality
              } else if (value == 'contacts') {
                // Implement contacts functionality
              } else if (value == 'refresh') {
                // Implement refresh functionality
              } else if (value == 'help') {
                // Implement help functionality
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.group),
            title: Text('New Group'),
            onTap: () {
              // Handle New Group item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Row(
              children: [
                Text('New Contact'),
                Spacer(),
                Icon(Icons.qr_code),
              ],
            ),
            onTap: () {
              // Handle New Contact item tap
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Contacts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Dummy Contacts List
          for (int i = 0; i < 5; i++)
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://placeimg.com/200/200/people'),
              ),
              title: Text('Contact Name ${i + 1}'),
              subtitle: Text('Bio of Contact ${i + 1}'),
              onTap: () {
                // Handle contact item tap
              },
            ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Invite to Flarez Chat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Dummy Contacts List
          for (int i = 0; i < 5; i++)
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://placeimg.com/200/200/people'),
              ),
              title: Row(
                children: [
                  Text('Contact Name ${i + 1}'),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Handle invite button tap
                    },
                    child: Text(
                      'Invite',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Handle contact item tap
              },
            ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share a Link'),
            onTap: () {
              // Handle Share a List item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Contact Help'),
            onTap: () {
              // Handle Contact Help item tap
            },
          ),
        ],
      ),
    );
  }
}
