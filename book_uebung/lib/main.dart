import 'dart:async';

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
  late PizzaOrderBloC _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PizzaOrderBloC();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<PizzaOrderStatus>(
          initialData: PizzaOrderStatus.none,
        stream: _bloc.orderChanges,
          builder: (context, streamSnapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pizza-Service'),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: _bloc.onNewOrder,
                    child: Text('Bestellung Aufgeben')),
                const SizedBox(
                  height: 16,
                ),
                Text('Bestellstatus: ${streamSnapshot.data}')
              ],
            );
          },
      )),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

enum PizzaOrderStatus { none, ordered, delivered }

class PizzaOrderBloC {
  final StreamController<PizzaOrderStatus> _orderStatusController = StreamController<PizzaOrderStatus>();

  Stream<PizzaOrderStatus> get orderChanges => _orderStatusController.stream;

  void onNewOrder() => _orderStatusController.sink.add(PizzaOrderStatus.ordered);

  void dispose() => _orderStatusController.close();
}













