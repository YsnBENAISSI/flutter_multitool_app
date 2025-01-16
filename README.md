# Flutter Multi-Tool App

A modern Flutter application that combines multiple utility tools in one place, featuring a calculator and weather information retrieval using the OpenWeatherMap API.

## Features

### Calculator
- Modern UI with material design
- Basic arithmetic operations (+, -, *, /)
- Input validation for numbers
- Real-time calculation display

### Weather Tool
- City-based weather search
- Displays current temperature, humidity, and pressure
- Shows weather conditions with icons
- Detailed weather information in pop-up dialog
- Integration with OpenWeatherMap API
- Country flags display

### Navigation
- Clean main menu interface
- Drawer navigation available on all pages
- Easy switching between tools
- Intuitive user flow

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- OpenWeatherMap API key

### Installation

1. Clone the repository
```bash
[git clone https://github.com/YsnBENAISSI/flutter_multitool_app.git
```

2. Navigate to project directory
```bash
cd flutter_multitool_app
```

3. Install dependencies
```bash
flutter pub get
```

4. Create a `Constant.dart` file in the `lib` folder and add your API key:
```dart
const String OPENWEATHER_API_KEY = 'your_api_key_here';
const String weatherApi = 'https://api.openweathermap.org/data/2.5/weather';
const String flagsApi = 'https://flagsapi.com/';
```

5. Run the app
```bash
flutter run
```

### Dependencies

- http: ^1.1.0
- intl: ^0.18.1

## Project Structure

```
lib/
  ├── main.dart
  ├── Constant.dart
  ├── pages/
  │   ├── calculator.dart
      ├── WeatherApiCaller.dart
  │   └── weather.dart
  └── services/
      └── api_caller.dart
```

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Acknowledgments

- OpenWeatherMap API for weather data
- Flags API for country flags
- Flutter team for the amazing framework
