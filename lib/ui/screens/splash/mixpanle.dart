import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4f44e0),
        title: const Text('Mixpanel Demo'),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextButton(
              child: const Text('GROUP'),
              onPressed: () {
                Navigator.pushNamed(context, '/group');
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextButton(
              child: const Text('GROUP'),
              onPressed: () {
                Navigator.pushNamed(context, '/group');
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextButton(
              child: const Text('GROUP'),
              onPressed: () {
                Navigator.pushNamed(context, '/group');
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextButton(
              child: const Text('GROUP'),
              onPressed: () {
                Navigator.pushNamed(context, '/group');
              },
            ),
          ),
        ],
      )),
    );
  }
}
