//
//  StatCard.swift
//  Volleyball App
//
//  Created by E2617595 on 27/6/2568 BE.
//


import SwiftUI

// MARK: - Model
struct StatCard: Identifiable {
    let id = UUID()
    let title: String       // e.g. "Serve Reception"
    let iconName: String    // image asset name or SF Symbol
    let gradient: [Color]   // background gradient colors
    let subtitle: String    // e.g. "percent", "Errors", "Total"
    let value: String       // e.g. "52%", "3", "7"
}

// MARK: - My Stats Screen
struct MyStatsView: View {
    @State private var selectedSegment = 0
    private let segments = ["Latest Match", "Past Matches"]

    // Sample data
    private let latestCards: [StatCard] = [
        .init(title: "Serve Reception", iconName: "iconServeReceive",
              gradient: [Color.red, Color.orange], subtitle: "percent", value: "52%"),
        .init(title: "Digging", iconName: "iconDigging",
              gradient: [Color.purple, Color.blue], subtitle: "percent", value: "41%"),
        .init(title: "Serving", iconName: "iconServing",
              gradient: [Color.orange, Color.yellow], subtitle: "percent", value: "73%"),
        .init(title: "Attacks", iconName: "iconAttacks",
              gradient: [Color.blue, Color.cyan], subtitle: "percent", value: "52%"),
        .init(title: "Setting", iconName: "iconSetting",
              gradient: [Color.indigo, Color.purple], subtitle: "Errors", value: "3"),
        .init(title: "Blocks", iconName: "iconBlocking",
              gradient: [Color.green, Color.teal], subtitle: "Total", value: "7")
    ]
    private let pastCards: [StatCard] = [] // populate as needed

    var body: some View {
        VStack(spacing: 0) {
            // Top bar
            HStack {
                Button(action: { /* Navigate home */ }) {
                    Image(systemName: "house")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Spacer()
                Text("My Stats")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                // invisible to balance
                Image(systemName: "house")
                    .opacity(0)
                    .frame(width: 24)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .background(Color(.systemGray6))

            // Segmented control
            Picker("", selection: $selectedSegment) {
                ForEach(0..<segments.count, id: \ .self) { idx in
                    Text(segments[idx]).tag(idx)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Grid of stat cards
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(selectedSegment == 0 ? latestCards : pastCards) { card in
                        StatCardView(card: card)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color(.systemGray6))
        }
    }
}

// MARK: - Card View
struct StatCardView: View {
    let card: StatCard
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            HStack {
                Image(card.iconName)
                    .renderingMode(.template)
                    .font(.largeTitle)
                    .foregroundColor(.white.opacity(0.8))
                Spacer()
                VStack(alignment: .trailing) {
                    Text(card.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text(card.value)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(height: 140)
        .background(
            LinearGradient(
                gradient: Gradient(colors: card.gradient),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

// MARK: - Root Content with Tab Bar
struct ContentView: View {
    var body: some View {
        TabView {
            MyStatsView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My Stats")
                }
            // Placeholder for other tabs
            Text("Team Stats View")
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Team Stats")
                }
            Text("New Game View")
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("New Game")
                }
        }
    }
}

// MARK: - Preview
struct MyStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
