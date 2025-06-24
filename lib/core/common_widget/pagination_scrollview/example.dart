import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_bloc.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_scrollview.dart';

class MyItem {
  final String title;
  MyItem(this.title);
}

Future<List<MyItem>> fetchMyItems(int page) async {
  await Future.delayed(Duration(milliseconds: 800));
  return List.generate(10, (i) => MyItem("Item ${i + (page - 1) * 10}"));
}

class PaginationExample extends StatelessWidget {
  final bloc = PaginationBloc<MyItem>(fetchPage: fetchMyItems);

  PaginationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination List")),
      body: PaginationScrollView<MyItem>(
        bloc: bloc,
        itemBuilder: (context, item) => ListTile(title: Text(item.title)),
      ),
    );
  }
}
