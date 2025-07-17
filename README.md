# 🌤️ Weather App — iOS Developer Assessment Task

This is a simple Weather App built using **Swift**, **UIKit**, and **MVVM architecture**. The app allows users to search for any city and fetch the current weather details using the **OpenWeatherMap API**.

---

## 📱 Features

- 🔍 **Search by City** – Enter a city name and fetch current weather data.
- 🌡️ Displays:
  - City name
  - Temperature (in Celsius)
  - Weather condition (e.g., Cloudy, Rain)
  - Corresponding weather icon
- 🔄 **Pull to Refresh**
- 📡 **Network Reachability** – Notifies user when internet connection is unavailable.
- 📛 **Error Handling** – Shows user-friendly error messages using toast.
- 🧱 Follows **MVVM** design pattern for separation of concerns and cleaner code.

---

## 📂 Project Structure

```plaintext
WeatherApp
├── Models
│   └── WeatherResponse.swift
├── ViewModels
│   └── WeatherViewControllerViewModel.swift
├── CellXibS
│   ├── WeatherViewController.swift
│   ├── SearchTableViewCell.swift
│   ├── CityNameTableViewCell.swift
│   └── WeatherDataTableViewCell.swift
├── Resources
│   └── cities.json
├── Networking
│   └── APIManager.swift
