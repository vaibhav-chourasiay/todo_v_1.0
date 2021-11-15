// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("SpickTodo"),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          CardWeight(),
          CardWeight(),
          CardWeight(),
          CardWeight(),
          CardWeight(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}

class CardWeight extends StatefulWidget {
  const CardWeight({Key? key}) : super(key: key);

  @override
  _CardWeightState createState() => _CardWeightState();
}

class _CardWeightState extends State<CardWeight> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent[100],
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(CupertinoIcons.bag)],
        ),
        title: Text(
          "some work",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black38,
          ),
        ),
        subtitle: Text(
          "work is to do multiple job in two days .",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
              value: value,
              onChanged: (value) {
                this.value = value!;
                setState(() {});
              },
              activeColor: Colors.deepPurple,
            )
          ],
        ),
      ),
    );
  }
}
