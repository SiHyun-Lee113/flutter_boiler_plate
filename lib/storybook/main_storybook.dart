import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyStorybook());

class MyStorybook extends StatelessWidget {
  const MyStorybook({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      stories: [
        Story(
          name: 'Buttons / Primary',
          builder: (_) => ElevatedButton(
            onPressed: () {},
            child: const Text('Primary'),
          ),
        ),
        Story(
          name: 'Text / Headline',
          builder: (_) => const Text(
            'Headline',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
