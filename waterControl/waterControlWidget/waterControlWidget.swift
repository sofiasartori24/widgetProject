import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quantidadeDesejada: "2000", quantidadeConsumida: "500")
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(), configuration: configuration, quantidadeDesejada: ContentView.shared.quantidadeConsumida, quantidadeConsumida: ContentView.shared.quantidadeConsumida)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, quantidadeDesejada: ContentView.shared.quantidadeDesejada, quantidadeConsumida: ContentView.shared.quantidadeConsumida)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .after(.now.advanced(by: 10)))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let quantidadeDesejada: String
    let quantidadeConsumida: String
}

struct waterControlWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @State var progress: CGFloat = 0
    @State var startAnimation: CGFloat = 0
    @State var proporcao = 0
    
    
    var entry: Provider.Entry
    
    
    
    var body: some View {

        //view para cada tamanho de widget
        switch widgetFamily {
        
        
        case .systemSmall:
            GeometryReader { reader in
                ZStack {
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text("\(entry.quantidadeConsumida)mL/\(entry.quantidadeDesejada)mL")
                                .font(.caption)
                        }.padding(6)
                        Spacer()
                        VStack(spacing: 0) {
                            WaterWave2(height: 75 * CGFloat(proporcao) * 0.2) // Ajuste a altura da ondulação conforme necessário
                                .foregroundColor(.cyan)
                            Rectangle()
                                .frame(height: 65 * CGFloat(proporcao))
                                .foregroundColor(.cyan)
                        }
                    }
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: 20)
                                    .frame(height: 1)
                            } //linhas vermelhas
                            Spacer()
                        }
                    }

                }.onAppear {
                    let quantidadeDesejada = entry.quantidadeDesejada
                    let quantidadeConsumida = entry.quantidadeConsumida
                    
                    let quantidadeDesejadaDouble = Double(quantidadeDesejada) ?? 0
                    let cg = CGFloat(quantidadeDesejadaDouble)
                    let quantidadeConsumidaDouble = Double(quantidadeDesejada) ?? 0
                    let cg2 = CGFloat(quantidadeConsumidaDouble)
                    proporcao = Int(min(1.0, quantidadeConsumidaDouble / quantidadeDesejadaDouble))
                    
                } //calculos de proporcao da agua
            }
            
        default:
            Text("Not Implemented yet!")
        }
        
        
        
    }
}

struct WaterWave2: Shape {
    var height: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveWidth = rect.width
        let waveHeight = height

        path.move(to: CGPoint(x: 0, y: rect.height - waveHeight)) // Comece na parte inferior

        var x: CGFloat = 0
        while x < waveWidth {
            path.addQuadCurve(to: CGPoint(x: x + waveWidth * 0.25, y: rect.height - waveHeight), control: CGPoint(x: x + waveWidth * 0.125, y: rect.height - waveHeight + waveHeight * 0.5))
            path.addQuadCurve(to: CGPoint(x: x + waveWidth * 0.5, y: rect.height - waveHeight), control: CGPoint(x: x + waveWidth * 0.375, y: rect.height - waveHeight - waveHeight * 0.5))
            x += waveWidth * 0.5
        }

        path.addLine(to: CGPoint(x: waveWidth, y: rect.height)) // Linha reta até a parte inferior
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct waterControlWidget: Widget {
    
    let kind: String = "waterControlWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            waterControlWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

//struct waterControlWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        waterControlWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
