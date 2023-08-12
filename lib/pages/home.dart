import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  double start = 0;
  double end = 0;
  bool visible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            start = scrollController.offset;
            return true;
          }

          if (notification is ScrollEndNotification) {
            return true;
          }

          if (notification is ScrollUpdateNotification) {
            end = scrollController.offset;
            if (start < end) {
              log('move up');
              setState(() {
                visible = false;
              });
            } else {
              log('move down');
              setState(() {
                visible = true;
              });
            }

            return true;
          }

          return false;
        },
        child: ListView.builder(
          controller: scrollController,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Item ${index + 1}'),
            );
          },
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        height: (visible) ? 64 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.feed),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
