import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFile = 'No file selected';
  DateTime? selectedDate;

  void _selectFile() {
    setState(() {
      selectedFile = 'example_document.pdf'; // Mocked file selection
    });
  }

  DateTimeRange? selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File and Date Range Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _selectFile, child: const Text('Browse')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDateRange(context),
              child: const Text('Select Date Range'),
            ),
            const SizedBox(height: 20),
            Text('Selected File: $selectedFile'),
            const SizedBox(height: 10),
            Text(
              selectedDateRange != null
                  ? 'Selected Range: ${selectedDateRange!.start.toLocal().toString().split(' ')[0]} - ${selectedDateRange!.end.toLocal().toString().split(' ')[0]}'
                  : 'Selected Range: None',
            ),
          ],
        ),
      ),
    );
  }
}
