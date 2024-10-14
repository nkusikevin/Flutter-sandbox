import 'package:blockie/counter/counter_cubit.dart';
import 'package:blockie/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(0),
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state < 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Negative Value Not Allowed',
                    style: TextStyle(color: Colors.red)),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state == 10) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have reached the limit 10',
                    style: TextStyle(color: Color.fromARGB(255, 6, 255, 56))),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Counterview(),
      ),
    );
  }
}
