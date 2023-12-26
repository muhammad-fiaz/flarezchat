import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  ThemeMode _currentTheme = ThemeMode.system;

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text('Light'),
                onTap: () {
                  setState(() {
                    _currentTheme = ThemeMode.light;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.nightlight_round),
                title: Text('Dark'),
                onTap: () {
                  setState(() {
                    _currentTheme = ThemeMode.dark;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_system_daydream),
                title: Text('System Default'),
                onTap: () {
                  setState(() {
                    _currentTheme = ThemeMode.system;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Display',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Theme'),
            subtitle: Text(_getThemeSubtitle()),
            onTap: () {
              _showThemeSelectionDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.wallpaper),
            title: Text('Wallpaper'),
            subtitle: Text('System default'),
          ),
        ],
      ),
    );
  }

  String _getThemeSubtitle() {
    if (_currentTheme == ThemeMode.light) {
      return 'Light';
    } else if (_currentTheme == ThemeMode.dark) {
      return 'Dark';
    } else {
      return 'System default';
    }
  }
}
