import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/example.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginationExample(),
    );
  }
}
