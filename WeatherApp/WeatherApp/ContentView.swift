//
//  ContentView.swift
//  WeatherApp
//
//  Created by Venky on 3/17/25.
//

import SwiftUI
import Combine

// MARK: - Weather View
struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("WeatherWise")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Your Personal Weather Companion")
                .font(.headline)
                .foregroundColor(.gray)
                
            TextField("Enter City", text: $viewModel.city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .multilineTextAlignment(.center)
                
            Button(action: viewModel.fetchWeather) {
                Text("Get Weather")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack(spacing: 10) {
                    Text(viewModel.temperature)
                        .font(.system(size: 50, weight: .bold))
                    Text(viewModel.description)
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text(viewModel.windSpeed)
                    Text(viewModel.cloudiness)
                    Text(viewModel.country)
                    Text(viewModel.sunrise)
                    Text(viewModel.sunset)
                    Text(viewModel.visibility)
                    Text(viewModel.timezone)
                }
                .padding()
            }
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    WeatherView()
}
