import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Providers.dart';

final helloWorldProvider = StateProvider<String>((_) => 'Hello w55o44rld');

class MyTestingScreen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    var value = ref.watch(helloWorldProvider1);
    return Scaffold(
      body: Center(
        child: Column (
          children: [
            Text(
            'Value: $value',
            ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Colors.green)),
            onPressed: () => {
              ref.read(helloWorldProvider1.notifier).state = "Testing",
            },
            child: const Text(
              'Change value',
              style: TextStyle(color: Colors.black),
            )
          ),
        ],
        )
      )
    );
  }
}