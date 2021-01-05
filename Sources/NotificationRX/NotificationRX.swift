import SwiftUI

/// `RXNotifier` is  a type of `ObservableObject` and should be used globally as `@EnvironmentObject`.
/// It allows to dispatch notifications and by storing them in queue.
///
/// - Parameter timeout: Time after notification should be destroyed. Default: 2
///
final class RXNotifier: ObservableObject {
    private var queue: [RXNotification] = []
    @Published var current: RXNotification? = nil
    
    let timeout: Double

    
    init(_ timeout: Double = 2) {
        self.timeout = timeout
    }
    
    func dispatch(_ notification: RXNotification) {
        queue.append(notification)
        if current == nil, let next = queue.first{
            launchNotification(next)
        }
        
    }
    
    private func onCompletetion() {
        queue.removeFirst()
        if let next = queue.first {
            launchNotification(next)
        } else {
            current = nil
        }
    }
    
    private func launchNotification(_ notification: RXNotification) {
        current = notification
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            self.onCompletetion()
        }
    }
}

struct RXNotifierView: View {
    @ObservedObject var notifier: RXNotifier
    
    var body: some View {
        VStack {
            if let notification = notifier.current {
                HStack {
                    Image(systemName: notification.type.rawValue)
                        .imageScale(.large)
                    Text(notification.content.title)
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .transition(AnyTransition.opacity.combined(with: .move(edge: .top)).combined(with: .scale))
            }
        }
    }
}

struct RXNotification: Equatable {
    let id: UUID
    let type: NotificationType
    let content: Content
    
    enum NotificationType: String {
        case info = "info.circle"
        case success = "checkmark.circle"
        case warning = "exclamationmark.circle"
        case error = "xmark.circle"
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
