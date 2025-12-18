# Overview

My Flutter application allows users to convert temperatures between Fahrenheit, Celsius, and Kelvin. My app includes the following

-   A dropdown menu to select the conversion type

-   A text field for entering a numeric value

-   Real-time input validation to ensure only numeric values are entered

-   Dynamic background and text color changes when the user taps anywhere on the screen

-   Immediate conversion display once a valid input is entered

## How to run

1.  Ensure Flutter is installed on your machine

2.  Copy the app code into a new Flutter project and paste it into main.dart

1.  To create a new Flutter project, just flutter create app_name and then cd app_name

4.  Run the app using flutter run in the command line

5.  Select the device of your choice

6.  Tap anywhere on the screen to cycle background colors

7.  Enter a temperature in the text field, and select a conversion type from the dropdown menu

8.  The converted temperature appears immediately below the text field

## Color Palette

-   I have a list of 5 colors for the background (Black, white, red, blue, and green)

-   When the background is black, the text, input, labels, and results change to white to remain readable

-   For all the other backgrounds, the text remains black

-   This ensures good visual contrast and readability

## Test Inputs

Input validation: Only numbers are allowed to be entered in the text field

| Conversion Type        | Input     | Expected Output | Notes/Edge Case               |
|------------------------|----------|----------------|-------------------------------|
| Fahrenheit -> Celsius  | 32       | 0.00 ºC        | Freezing point of water       |
| Fahrenheit -> Kelvin   | 32       | 273.15 K       | Freezing point of water       |
| Celsius -> Fahrenheit  | 100      | 212.00 ºF      | Boiling point of water        |
| Celsius -> Kelvin      | -273.15  | 0.00 K         | Absolute zero edge case       |
| Kelvin -> Celsius      | 0        | -273.15 ºC     | Absolute zero edge case       |
| Kelvin -> Fahrenheit   | 373.15   | 212.00 ºF      | Boiling point of water        |
| Fahrenheit -> Celsius  | -459.67  | -273.15 ºC     | Absolute zero edge case       |


Loom Link for Demo: <https://www.loom.com/share/99ed681768b74fa2be1d8b2761e4cc20>
