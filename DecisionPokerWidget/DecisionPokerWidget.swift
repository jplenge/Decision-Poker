//
//  DecisionPokerWidget.swift
//  DecisionPokerWidget
//
//  Created by Jürgen Plenge on 01.06.21.
//  Copyright © 2021 Jodi Szarko. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct DecisionProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> DecisionEntry {
        DecisionEntry(date: Date(),
                      decision: Decision(deckname: "Houshold Chores",
                                         date: Date(),
                                         selectedCards: ["Wash Dishes", "Clean Bathroom"]))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let date = Date()
        var entry: DecisionEntry
        
        entry = DecisionEntry(date: date,
                              decision: Decision(deckname: "Houshold Chores",
                                                 date: Date(),
                                                 selectedCards: ["Wash Dishes", "Clean Bathroom"]))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DecisionEntry>) -> Void) {
        // fetch hstory from core data
        // Create a timeline entry for "now."
        let date = Date()
        
        let lastDecision = readJSON(named: "lastDecision", Decision.self) ?? Decision(deckname: "", date: Date(), selectedCards: [])
        
        let entry = DecisionEntry(
            date: date,
            decision: lastDecision
        )
        // Create a date that's 15 minute in the future.
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!
        // Create the timeline with the entry and a reload policy with the date
        // for the next update.
        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdateDate)
        )
        // Call the completion to pass the timeline to WidgetKit.
        completion(timeline)
    }
    
    func readJSON<T: Codable>(named: String, _ object: T.Type) -> T? {
        do {
            let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.de.ipomic.DecisionPoker")!.appendingPathComponent(named)
            
            let data = try Data(contentsOf: fileURL)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            
            return object
        } catch {
            return nil
        }
    }

}

struct DecisionEntry: TimelineEntry {
    var date: Date
    var decision: Decision
}

struct DecisionPokerWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: DecisionEntry
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: DecisionPokerLastDecision(entry: entry)
        case .systemMedium: DecisionPokerMedium(entry: entry)
        case .systemLarge: DecisionPokerDetails(entry: entry)
        default:  DecisionPokerDetails(entry: entry)
        }
        
    }
}

struct DecisionPokerLastDecision: View {
    var entry: DecisionEntry
    
    var body: some View {
        VStack {
            
            Text("Latest Decision")
                .font(.subheadline)
                .fontDesign(.rounded)
                .foregroundColor(.green)
                .padding(2)
            
            Text(entry.decision.deckname)
                .font(.subheadline)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct DecisionPokerMedium: View {
    var entry: DecisionEntry
    
    var body: some View {
        VStack {
            
            Text("Latest Decision")
                .font(.subheadline)
                .foregroundColor(.green)
                .fontDesign(.rounded)
                .padding(.top, 5)
                        
            Text(entry.decision.deckname)
                .font(.body)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primary)
                .padding(.top, 5)

            HStack {
                Spacer()
                Text(entry.decision.date, style: .date)
                    .padding()
                    .font(.footnote)
                    .fontDesign(.rounded)

            }
        }
    }
}

struct DecisionPokerDetails: View {
    var entry: DecisionEntry
    
    var body: some View {
        VStack {
            
            Text("Latest Decision")
                .font(.subheadline)
                .fontDesign(.rounded)
                .foregroundColor(.green)
                .padding()
            
            Text(entry.decision.deckname)
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primary)
            
            VStack(alignment: .leading) {
                ForEach(entry.decision.selectedCards, id: \.self) {cardName in
                    VStack(alignment: .center) {
                        HStack {
                            Image(systemName: "chart.bar.doc.horizontal")
                                .foregroundColor(Color.secondary)
                                .font(.body)
                            
                            Text("\(cardName)")
                                .fontDesign(.rounded)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.secondary)
                            Spacer()
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(5)
            
            Spacer()
            
            HStack {
                Spacer()
                Text(entry.decision.date, style: .date)
                    .padding()
                    .font(.footnote)
                    .fontDesign(.rounded)
                
            }
        }
    }
}

@main
struct DecisionPokerWidget: Widget {
    private let kind: String = "DecisionPokerWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DecisionProvider()
        ) { entry in
            DecisionPokerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Latest Decision")
        .description("Shows your latest decision")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct DecisionPokerWidget_Previews: PreviewProvider {
    static var previews: some View {
        DecisionPokerWidgetEntryView(entry: DecisionEntry(date: Date(),
                                                          decision: Decision(deckname: "House Hold Chores and other Thing",
                                                                             date: Date(),
                                                                             selectedCards: ["rot", "green", "violett"])))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
            .environment(\.locale, Locale(identifier: "de"))
    }
}
