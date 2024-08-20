import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PizzaOrderWidget(),
    );
  }
}

class PizzaOrderWidget extends StatefulWidget {
  const PizzaOrderWidget({super.key});

  @override
  State<PizzaOrderWidget> createState() => _PizzaOrderWidgetState();
}

class _PizzaOrderWidgetState extends State<PizzaOrderWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderBloC();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: bloc.makeReadyForOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<PizzaOrderStatus> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pizze-Service'),
                const SizedBox(height: 16),
                Text('Bestellstatus: ${snapshot.data ?? 'bitte warten'}'),
                //dragQueen()
                draqableQueen()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget draqableQueen() {
    int tosses = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Draggable(
            data: tosses,
            child: Container(
              color: Colors.black12,
              height: 100,
              width: 100,
              child: Center(
                child: Text('Ziehen'),
              ),
            ),
            childWhenDragging: Container(
              color: Colors.red,
              height: 100,
              width: 100,
            ),
            feedback: Container(
              color: Colors.green,
              height: 100,
              width: 100,
            )),
        const SizedBox(height: 100),
        DragTarget<int>(
            onAcceptWithDetails: (data) => ++tosses,
            onWillAcceptWithDetails: (tosses) => true,
            builder: (context, candidateData, rejectData) {
              return Container(
                color: candidateData.isEmpty ? Colors.black12 : Colors.yellow,
                height: 100,
                width: 100,
                child: Center(
                  child: Text(tosses.toString()),
                ),
              );
            })
      ],
    );
  }

  Widget dragQueen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Über dismissable'),
        Dismissible(
          key: UniqueKey(),
          child: Container(
            height: 100,
            width: double.infinity,
            color: Colors.green,
          ),
          background: ColoredBox(
            color: Colors.red,
          ),
          secondaryBackground: Container(
            height: 20,
            width: double.infinity,
            color: Colors.amberAccent,
          ),
          confirmDismiss: (direction) async =>
              direction == DismissDirection.endToStart,
        ),
        Text('Unter dem Dismissable')
      ],
    );
  }
}

enum PizzaOrderStatus { none, ready, ordered, delivered }

class PizzaOrderBloC {
  PizzaOrderStatus _currentStatus = PizzaOrderStatus.none;

  PizzaOrderStatus get currentStatus => _currentStatus;

  Future<PizzaOrderStatus> makeReadyForOrders() async {
    await Future.delayed(Duration(seconds: 5));
    _currentStatus = PizzaOrderStatus.ready;

    return _currentStatus;
  }
}
