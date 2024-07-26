import 'package:flutter/material.dart';

void main() => runApp(const TempConverterApp());

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _history = '';
  bool _isFahrenheitToCelsius = true;

  void _convertTemperature() {
    final input = double.tryParse(_controller.text);
    if (input == null) return;

    double converted;
    if (_isFahrenheitToCelsius) {
      converted = (input - 32) * 5 / 9;
    } else {
      converted = input * 9 / 5 + 32;
    }

    setState(() {
      _result = converted.toStringAsFixed(2);
      _history =
          '$_history${_isFahrenheitToCelsius ? 'F to C' : 'C to F'}: ${input.toStringAsFixed(1)} => $_result\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Conversion:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: const Text('Fahrenheit to Celsius'),
                        selected: _isFahrenheitToCelsius,
                        onSelected: (bool selected) {
                          setState(() {
                            _isFahrenheitToCelsius = true;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Celsius to Fahrenheit'),
                        selected: !_isFahrenheitToCelsius,
                        onSelected: (bool selected) {
                          setState(() {
                            _isFahrenheitToCelsius = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Temperature',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertTemperature,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('CONVERT'),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Result',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _result,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'History:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _history,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
