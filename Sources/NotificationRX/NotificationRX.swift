import SwiftUI


struct RXNotifier: View {
    @Binding var notifications: [RXNotification]
    
    init(_ notifications: Binding<[RXNotification]>) {
        self._notifications = notifications
    }
    
    var body: some View {
        VStack {
            
        }
        .onChange(of: notifications) { value in
            
        }
    }
}

struct RXNotification: Equatable {
    let id: UUID
    let type: NotificationType
    let content: Content
    
    enum NotificationType {
        case info
        case success
        case warning
        case error
    }

    struct Content {
        let title: String
        let desctiption: String

        init(_ title: String, _ description: String) {
            self.title = title
            self.desctiption = description
        }
    }
    
    init(_ type: NotificationType = .info, _ content: Content) {
        self.id = UUID()
        self.type = type
        self.content = content
    }
    
    static func == (lhs: RXNotification, rhs: RXNotification) -> Bool {
        return lhs.id == rhs.id
    }
}

//struct RXNotification: View {
//    let type: NotificationType
//    let content: Content
//    @State private var visible: Bool = true
//
//    init(_ type: NotificationType = .info, _ content: Content) {
//        self.type = type
//        self.content = content
//    }
//
//    enum NotificationType {
//        case info
//        case success
//        case warning
//        case error
//    }
//
//    struct Content {
//        let title: String
//        let desctiption: String
//
//        init(_ title: String, _ description: String) {
//            self.title = title
//            self.desctiption = description
//        }
//    }
//
//
//    var body: some View {
//        VStack {
//            if visible {
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                    Text("Product saved in cart")
//                    Spacer()
//                }
//                .padding()
//                .background(Color.gray)
//                .cornerRadius(10)
//                .transition(.asymmetric(insertion: .slide, removal: .slide))
//            }
//
//            Spacer()
//
//            Button(visible ? "Hide" : "Show") {
//                withAnimation {
//                    visible.toggle()
//                }
//            }
//        }
//        .padding()
//    }
//}

//struct NWSNotification_Previews: PreviewProvider {
//    static var previews: some View {
//        RXNotification(.info, .init("", ""))
//    }
//}
