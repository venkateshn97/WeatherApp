//
//  Weather.swift
//  WeatherApp
//
//  Created by Venky on 3/17/25.
//

import Foundation

// MARK: - Weather Model
struct Weather: Codable {
    let name: String
    let coord: Coordinate
    let main: Main
    let weather: [WeatherCondition]
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let visibility: Int
    let timezone: Int
    let dt: Int
}


struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
}

struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
