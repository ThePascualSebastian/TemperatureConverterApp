import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for filtering numeric input

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      debugShowCheckedModeBanner: false,
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  List<String> dropDownOptions = [
    'Fahrenheit -> Celsius',
    'Fahrenheit -> Kelvin',
    'Celsius -> Fahrenheit',
    'Celsius -> Kelvin',
    'Kelvin -> Celsius',
    'Kelvin -> Fahrenheit',
  ];
  late String optionSelected = dropDownOptions[0];

  int colorCounter = 0;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.white,
  ];
  late Color currentColor = colors[0];
  Color textColor = Colors.black;

  final TextEditingController controller = TextEditingController();
  String? errorMessage;
  String? result;

  // Changes background color on tap
  void changeBackgroundColor() {
    setState(() {
      colorCounter++;
      int index = colorCounter % colors.length;
      currentColor = colors[index];
      textColor = (currentColor == Colors.black) ? Colors.white : Colors.black;
    });
  }

  // Validates input and convert if valid
  void validateInput(String value) {
    setState(() {
      if (value.isEmpty) {
        errorMessage = "Please enter a number";
        result = null;
      } else if (double.tryParse(value) == null) {
        errorMessage = "Invalid character";
        result = null;
      } else {
        errorMessage = null;
        double input = double.parse(value);
        result = convertTemperature(input, optionSelected);
      }
    });
  }

  // Conversion logic
  String convertTemperature(double input, String option) {
    double calculation = 0;
    String unit = "";

    switch (option) {
      case 'Fahrenheit -> Celsius':
        calculation = (input - 32) * 5 / 9;
        unit = "°C";
        break;
      case 'Fahrenheit -> Kelvin':
        calculation = (input - 32) * 5 / 9 + 273.15;
        unit = "K";
        break;
      case 'Celsius -> Fahrenheit':
        calculation = (input * 9 / 5) + 32;
        unit = "°F";
        break;
      case 'Celsius -> Kelvin':
        calculation = input + 273.15;
        unit = "K";
        break;
      case 'Kelvin -> Celsius':
        calculation = input - 273.15;
        unit = "°C";
        break;
      case 'Kelvin -> Fahrenheit':
        calculation = (input - 273.15) * 9 / 5 + 32;
        unit = "°F";
        break;
      default:
        calculation = input;
        unit = "";
    }

    return "${calculation.toStringAsFixed(2)} $unit";
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose controller to free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Converter',
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
        backgroundColor: currentColor,
      ),
      backgroundColor: currentColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // works only on whitespace
        onTap: () => changeBackgroundColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  dropdownColor: currentColor,
                  iconEnabledColor: textColor,
                  value: optionSelected,
                  items: dropDownOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: textColor)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      optionSelected = newValue!;
                      // Recalculate if there is already a number entered
                      if (controller.text.isNotEmpty) {
                        validateInput(controller.text);
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^-?\d*\.?\d*$'), // allows only integers & decimals
                  ),
                ],
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: "Enter temperature",
                  labelStyle: TextStyle(color: textColor),
                  errorText: errorMessage,
                  errorStyle: TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 2),
                  ),
                ),
                onChanged: validateInput,
              ),
            ),
            const SizedBox(height: 20),
            if (result != null)
              Text(
                "Converted: $result",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}