//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Venky on 3/17/25.
//

import Foundation
import Combine


// MARK: - Weather ViewModel
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var temperature: String = "--"
    @Published var feelsLike: String = "--"
    @Published var tempRange: String = "--"
    @Published var description: String = "--"
    @Published var iconURL: String = ""
    @Published var humidity: String = "--"
    @Published var pressure: String = "--"
    @Published var windSpeed: String = "--"
    @Published var cloudiness: String = "--"
    @Published var country: String = "--"
    @Published var sunrise: String = "--"
    @Published var sunset: String = "--"
    @Published var visibility: String = "--"
    @Published var timezone: String = "--"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather() {
        guard !city.isEmpty else {
            errorMessage = "City name cannot be empty"
            return
        }
        
        let apiKey = "4a296421d662a9257ebd996b4aa6add0"  // Replace with your API key
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load weather: \(error.localizedDescription)"
                }
            }, receiveValue: { weather in
                self.temperature = "\(Int(weather.main.temp))°C"
                self.feelsLike = "Feels like \(Int(weather.main.feels_like))°C"
                self.tempRange = "Min: \(Int(weather.main.temp_min))°C / Max: \(Int(weather.main.temp_max))°C"
                self.humidity = "\(weather.main.humidity)%"
                self.pressure = "\(weather.main.pressure) hPa"
                self.description = weather.weather.first?.description.capitalized ?? ""
                self.iconURL = "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "")@2x.png"
                self.windSpeed = "Wind: \(weather.wind.speed) m/s"
                self.cloudiness = "Clouds: \(weather.clouds.all)%"
                self.country = "Country: \(weather.sys.country)"
                self.sunrise = "Sunrise: \(Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise)).formatted())"
                self.sunset = "Sunset: \(Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset)).formatted())"
                self.visibility = "Visibility: \(weather.visibility) meters"
                self.timezone = "Timezone Offset: \(weather.timezone) seconds"
            })
            .store(in: &cancellables)
    }
}
