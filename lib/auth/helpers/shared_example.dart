import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/SharedPrefManager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _savedUsername = '';
  int _savedAge = 0;

  // Function to save data
  Future<void> _saveData() async {
    String username = _usernameController.text;
    int age = int.tryParse(_ageController.text) ?? 0;

    await _sharedPrefManager.saveData('username', username);
    await _sharedPrefManager.saveData('age', age);

    _usernameController.clear();
    _ageController.clear();

    _showSnackBar('Data saved successfully!');
  }

  // Function to retrieve data
  Future<void> _retrieveData() async {
    String? username = await _sharedPrefManager.getData('username') as String?;
    int? age = await _sharedPrefManager.getData('age') as int?;

    setState(() {
      _savedUsername = username ?? 'No data';
      _savedAge = age ?? 0;
    });
  }

  // Function to clear all data
  Future<void> _clearData() async {
    await _sharedPrefManager.clearAll();

    setState(() {
      _savedUsername = '';
      _savedAge = 0;
    });

    _showSnackBar('All data cleared!');
  }

  // Function to show SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Enter Username'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Enter Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: const Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: _retrieveData,
                  child: const Text('Retrieve Data'),
                ),
                ElevatedButton(
                  onPressed: _clearData,
                  child: const Text('Clear Data'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Saved Username: $_savedUsername'),
            Text('Saved Age: $_savedAge'),
          ],
        ),
      ),
    );
  }
}
