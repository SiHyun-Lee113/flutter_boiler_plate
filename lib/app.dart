import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/example.dart';
import 'package:flutter_boiler_plate/feature/test_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Boilerplate')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestPage()));
                },
                child: const Text('Pagination Example')),
          ],
        ),
      ),
    );
  }
}
