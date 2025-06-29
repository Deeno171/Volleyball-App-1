//
//  StatisticCategory.swift
//  Volleyball App
//
//  Created by E2617595 on 26/6/2568 BE.
//


import SwiftUI

struct StatisticCategory: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String    // your asset name for the icon
    let gradient: [Color]
}

struct ChangeStatisticsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var selected: Set<UUID> = []
    
    // replace "iconXxx" with your asset names
    private let categories: [StatisticCategory] = [
        .init(name: "Serve Receive", iconName: "iconServeReceive",
              gradient: [Color.red, Color.orange]),
        .init(name: "Serving",      iconName: "iconServing",
              gradient: [Color.orange, Color.yellow]),
        .init(name: "Attacks",      iconName: "iconAttacks",
              gradient: [Color.blue, Color.cyan]),
        .init(name: "Setting",      iconName: "iconSetting",
              gradient: [Color.purple, Color.blue]),
        .init(name: "Blocking",     iconName: "iconBlocking",
              gradient: [Color.green, Color.teal]),
        .init(name: "Digging",      iconName: "iconDigging",
              gradient: [Color.indigo, Color.purple]),
        .init(name: "Rotations",    iconName: "iconRotations",
              gradient: [Color.red, Color.pink])
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom header with centered title
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Spacer()
                Text("Change Statistics")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                // Invisible placeholder to balance back button
                Image(systemName: "chevron.left")
                    .opacity(0)
                    .frame(width: 24)
            }
            .padding(.horizontal)
            .padding(.top)

            // Main content card
            VStack(spacing: 24) {
                ForEach(categories) { cat in
                    Button(action: { toggle(cat) }) {
                        HStack(spacing: 16) {
                            Image(systemName: selected.contains(cat.id) ? "checkmark.square.fill" : "square")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(cat.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Image(cat.iconName)
                                .renderingMode(.template)
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: cat.gradient),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Bottom buttons
            HStack(spacing: 20) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(FilledButtonSt(background: Color.gray.opacity(0.4)))

                Button("Change") {
                    // apply your change logic here
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(FilledButtonSt(background: Color.accentColor))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func toggle(_ cat: StatisticCategory) {
        if selected.contains(cat.id) {
            selected.remove(cat.id)
        } else {
            selected.insert(cat.id)
        }
    }
}

struct FilledButtonSt: ButtonStyle {
    let background: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 48)
            .foregroundColor(.white)
            .background(background)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

struct ChangeStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeStatisticsView()
    }
}
