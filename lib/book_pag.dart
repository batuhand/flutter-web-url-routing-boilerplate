import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  final int id;
  const BookPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(id.toString()),
    );
  }
}
