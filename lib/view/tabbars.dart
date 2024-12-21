import 'package:flutter/material.dart';
import 'package:fluttertest/view/older.dart';
import 'package:fluttertest/view/younger.dart';

class Tabbars extends StatefulWidget {
  const Tabbars({super.key});

  @override
  State<Tabbars> createState() => _TabbarsState();
}

class _TabbarsState extends State<Tabbars> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[600],
         
          bottom: TabBar(
            indicatorColor: Colors.amber,
            // indicatorWeight: 4.0,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: "Younger",
              
              ),
              Tab(text: "Older"),
            ],
          ),
        ),
        body:TabBarView(
            children: [
              Younger(),
              Older(),
            ],
          ),
      ),
    );
  }
}
