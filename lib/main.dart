import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  static const platform = MethodChannel('openUrlChannel');

  final String githubUrl = 'https://github.com/khachy/basic-app';
  final String hngUrl = 'https://hng.tech/hire/flutter-developers';

  const HomePage({super.key});

  Future<void> openURL(String url) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await platform.invokeMethod('openUrl', {'url': url});
      } else {
        print('Please open this link manually: $url');
      }
    } on PlatformException catch (e) {
      print('Failed to open URL: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => openURL(githubUrl),
              child: Text('Open GitHub Repo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => openURL(hngUrl),
              child: Text('Visit HNG Hire Flutter Developers Page'),
            ),
          ],
        ),
      ),
    );
  }
}
