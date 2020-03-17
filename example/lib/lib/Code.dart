import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  final String text;

  Code(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey.withOpacity(0.2),
      child: Text(
        text,
        style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),
    );
  }
}
