import 'package:flarezchat/app/screens/pages/Menu/StarredMessages.dart';
import 'package:flarezchat/app/screens/pages/settings/Settings.dart';
import 'package:flutter/material.dart';

import 'Contacts/NewContacts.dart';

/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<Map<String, dynamic>> _statusList = [
    {
      'image': 'assets/images/jack.png',
      'name': 'Status 1',
    },
    {
      'image': 'assets/images/jack.png',
      'name': 'Status 2',
    },
    {
      'image': 'assets/images/jack.png',
      'name': 'Status 3',
    },
    // Add more status items here
  ];


  bool _isMessageShowing = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flarez Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              // Implement camera icon functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search icon functionality
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('New Group'),
                value: 'new_group',
              ),
              const PopupMenuItem(
                child: Text('Starred Messages'),
                value: 'starred_messages',
              ),
              const PopupMenuItem(
                child: Text('Settings'),
                value: 'settings',
              ),
            ],
            onSelected: (value) {
              // Handle popup menu item selection
              if (value == 'new_group') {
                // Implement new group functionality
              } else if (value == 'starred_messages') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StarredMessagesPage()),
                );
                // Implement starred messages functionality
              } else if (value == 'settings') {
                // Implement settings functionality
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _statusList.length + 1,
              itemBuilder: (context, index) {
                if (_currentIndex == 2) {
                  // Don't show status circles on the "Calls" page
                  return SizedBox.shrink();
                } else if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      // Handle "Add Status" functionality
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.add,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  );
                } else {
                  final statusIndex = index - 1;
                  final statusImage = _statusList[statusIndex]['image'];
                  final statusName = _statusList[statusIndex]['name'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMessageShowing = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _isMessageShowing ? Colors.blue : Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(statusImage),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            statusName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },

            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                // Chat Page
                ListView(
                  children: [
                    _buildContactItem('Jack', 'assets/images/jack.png', 'Lorem ipsum dolor sit amet.', '10:30 AM'),
                    Divider(),
                    _buildContactItem('John', 'assets/images/jack.png', 'Lorem ipsum dolor sit amet.', 'Yesterday'),
                    Divider(),
                    _buildContactItem('Jane', 'assets/images/jack.png', 'Lorem ipsum dolor sit amet.', '2 days ago'),
                    Divider(),
                    _buildContactItem('Alice', 'assets/images/jack.png', 'Lorem ipsum dolor sit amet.', '5/10/2023'),
                    // Add more contact items here
                  ],
                ),

                // Group Page
                Center(child: Text('Group')),

                // Calls Page
                Center(child: Text('Calls')),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 70.0, right: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewContactPage()),
                  );
                },
                child: Icon(Icons.chat),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
  Widget _buildContactItem(String name, String imagePath, String lastMessage, String timestamp) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        timestamp,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }

}
