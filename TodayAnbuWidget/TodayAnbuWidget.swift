//
//  TodayAnbuWidget.swift
//  TodayAnbuWidget
//
//  Created by 장지수 on 2022/07/27.
//

import WidgetKit
import SwiftUI
import Intents

// 렌더링할 시기를 WidgetKit에 알려주는 타임라인을 생성함
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TodayAnbuWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text("안부 전화 한지 10일")
        }
    }
}

@main
struct TodayAnbuWidget: Widget {
    let kind: String = "오늘, 안부"

    var body: some WidgetConfiguration {
        //사용자가 구성할 수 있는 속성 -> Edit을 통해 위젯에 보여질 내용을 바꿀 수 있음
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TodayAnbuWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("오늘, 안부")
        .description("부모님께 드릴 전화가 있는지 리마인드 해드릴께요!.")
    }
}

struct TodayAnbuWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodayAnbuWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
