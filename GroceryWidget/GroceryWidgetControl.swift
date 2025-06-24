//
//  GroceryWidgetControl.swift
//  GroceryWidget
//
//  Created by Yenat Feyyisa on 3/25/25.
//

//import AppIntents
//import SwiftUI
//import WidgetKit
//
//struct GroceryWidgetControl: ControlWidget {
//    var body: some ControlWidgetConfiguration {
//        StaticControlConfiguration(
//            kind: "techconsulting.GroceryApp.GroceryWidget",
//            provider: Provider()
//        ) { value in
//            ControlWidgetToggle(
//                "Start Timer",
//                isOn: value,
//                action: StartTimerIntent()
//            ) { isRunning in
//                Label(isRunning ? "On" : "Off", systemImage: "timer")
//            }
//        }
//        .displayName("Timer")
//        .description("A an example control that runs a timer.")
//    }
//}
//
//extension GroceryWidgetControl {
//    struct Provider: ControlValueProvider {
//        var previewValue: Bool {
//            false
//        }
//
//        func currentValue() async throws -> Bool {
//            let isRunning = true // Check if the timer is running
//            return isRunning
//        }
//    }
//}
//
//struct StartTimerIntent: SetValueIntent {
//    static let title: LocalizedStringResource = "Start a timer"
//
//    @Parameter(title: "Timer is running")
//    var value: Bool
//
//    func perform() async throws -> some IntentResult {
//        // Start / stop the timer based on `value`.
//        return .result()
//    }
//}
