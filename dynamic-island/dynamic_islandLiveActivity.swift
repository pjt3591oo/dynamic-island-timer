//
//  dynamic_islandLiveActivity.swift
//  dynamic-island
//
//  Created by 박정태 on 2022/10/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct TimerAttributes: ActivityAttributes {
    public typealias TimeState = ContentState

    public struct ContentState: Codable, Hashable {
        var endDate: ClosedRange<Date>
    }

    var name: String
}

struct dynamic_islandLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.name)
                    // more content
                }
            } compactLeading: {
                Image(systemName: "timer")
            } compactTrailing: {
                Text(timerInterval: context.state.endDate, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 40)
                        .font(.caption2)
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
