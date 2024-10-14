import 'package:blockie/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counterview extends StatelessWidget {
  const Counterview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Counter Value: ${state}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    key: const Key('increment_floatingActionButton'),
                    onPressed: () => context.read<CounterCubit>().increment(),
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    key: const Key('decrement_floatingActionButton'),
                    onPressed: () => context.read<CounterCubit>().decrement(),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
