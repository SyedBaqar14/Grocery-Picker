import 'package:flutter/material.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/views/delegate/delegate_order_request.dart';
import 'package:flutter_picker_app/views/pick_list/pick_list_screens.dart';
import 'package:flutter_picker_app/views/return/return.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PickListScreens(),
    Return(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(elevation: 4,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pick List',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetConfig.kReturn)),
            label: 'Return',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kUniversalColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
