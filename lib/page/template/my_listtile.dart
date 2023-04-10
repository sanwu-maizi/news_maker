import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function function;
  const MyListTile({Key? key, required this.title, required this.icon, required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: icon,
      onTap: () async {
        function();
      }
    );
  }
}
