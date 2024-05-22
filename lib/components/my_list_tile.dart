import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const MyListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: Colors.grey,
        ),
        title: Text(widget.text),
        onTap: widget.onTap,
      ),
    );
  }
}
