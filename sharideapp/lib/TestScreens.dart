import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Providers.dart';

final helloWorldProvider = StateProvider<String>((_) => 'Hello w55o44rld');

// // 1. extend [ConsumerStatefulWidget]
// class HelloWorldWidget extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<HelloWorldWidget> createState() => _HelloWorldWidgetState();
// }

// // 2. extend [ConsumerState]
// class _HelloWorldWidgetState extends ConsumerState<HelloWorldWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // 3. if needed, we can read the provider inside initState
//     // final helloWorld = ref.read(helloWorldProvider1);
//     // print(helloWorld); // "Hello world"
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 4. use ref.watch() to get the value of the provider
//     var helloWorld = ref.watch(helloWorldProvider1);
//         return Scaffold(
//         appBar: AppBar(title: Text('Hello, $helloWorld')),
//         body: Container(
//             padding: EdgeInsets.all(15),
//             color: Colors.black,
//             child: Column(
//                 children: [
//                     Container(
//                         alignment: Alignment.centerRight,
//                         margin: EdgeInsets.only(right: 15),
//                         child: ElevatedButton(
//                                     onPressed: () => {
                                      
//                                     },
//                                     child: Text(
//                                     'Edit location',
//                                     style: TextStyle(color: Colors.black),
//                                     ),
//                                     style: ButtonStyle(
//                                         backgroundColor:
//                                             MaterialStateProperty.all(Colors.blue.shade800)),
//                         ),
//                     ),

//                 ]
//             )
//         )
//     );
//   }
// }

class MyTestingScreen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    var value = ref.watch(helloWorldProvider);
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
              ref.read(helloWorldProvider.notifier).state = "Testing",
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