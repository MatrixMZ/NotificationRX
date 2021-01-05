import XCTest
import SwiftUI
@testable import NotificationRX

final class NotificationRXTests: XCTestCase {
    @State var notifications: [RXNotification] = []
    var sut: RXNotifier!

    override func setUp() {
        super.setUp()
        
        sut = RXNotifier($notifications) { id in
            print(id)
        }
    }

    override func tearDown() {
        notifications = []
        super.tearDown()
    }

    func testAddNewNotifcation() {
        notifications.append(RXNotification(.info, .init("Title", "Description")))
    }
}
