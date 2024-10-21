import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final onPress;
  const SettingsScreen({super.key, this.onPress});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
   bool _isSelected = false;
   
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwitchListTile.adaptive(
          title: const Text('Lights'),
         // secondary: Icon(Icons.share),
          value: _isSelected,
           onChanged: widget.onPress
           ),
      ),
    );
  }
}