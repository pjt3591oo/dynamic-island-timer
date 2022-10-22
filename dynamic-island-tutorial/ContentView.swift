//
//  ContentView.swift
//  dynamic-island-tutorial
//
//  Created by 박정태 on 2022/10/22.
//

import SwiftUI
import ActivityKit

public struct TimerAttributes: ActivityAttributes {
    public typealias TimeState = ContentState

    public struct ContentState: Codable, Hashable {
        var endDate: ClosedRange<Date>
    }
    var name: String
}

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack (spacing: 1) {
                    HStack (spacing: 1) {
                        Button(action: { onTimerStart()}) {
                            HStack {
                                Spacer()
                                Text("타이머 시작").font(.headline)
                                Spacer()
                            }.frame(height: 60)
                        }.tint(.pink)
                        Button(action: { onTimerUpdate()}) {
                            HStack {
                                Spacer()
                                Text("초기화").font(.headline)
                                Spacer()
                            }.frame(height: 60)
                        }.tint(.pink)
                    }.tint(.purple)
                    Button(action: { onTimerStop()}) {
                        HStack {
                            Spacer()
                            Text("타이머 중지").font(.headline)
                            Spacer()
                        }.frame(height: 60)
                    }.tint(.pink)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 0))
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
    
    func onTimerStart() {
        Task {
            let widgetAttribute = TimerAttributes(name: "정태의 타이머")
            let initialContentState = TimerAttributes.ContentState(endDate: Date()...Date().addingTimeInterval(15 * 60))
            do {
               let widgetActivity = try Activity<TimerAttributes>.request(
                   attributes: widgetAttribute,
                   contentState: initialContentState,
                   pushType: nil)
               print("Requested a Widget Live Activity \(widgetActivity.id)")
           } catch (let error) {
               print("Error requesting widget Live Activity \(error.localizedDescription)")
           }
        }
    }
    
    func onTimerUpdate() {
        Task {
            let updateContentState = TimerAttributes.ContentState(endDate: Date()...Date().addingTimeInterval(20 * 60))
            for activity in Activity<TimerAttributes>.activities{
                await activity.update(using: updateContentState)
            }
        }
    }
    
    
    func onTimerStop() {
        Task {
            for activity in Activity<TimerAttributes>.activities{
                await activity.end()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
