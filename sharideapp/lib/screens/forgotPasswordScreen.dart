import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sharide'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text('Reset password:'),
              TextField(
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
