//
//  ContentView.swift
//  TestLocalNotification
//
//  Created by Joe Leung on 3/28/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var showAlert = false
    @State private var timeStamp = ""
    var body: some View {
        VStack {
            Spacer()
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }            }
            Spacer()
            Button("Schedule Notification") {
                let now = Date.now
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                timeStamp = formatter.string(from: now)
                
                let content = UNMutableNotificationContent()
                content.title = timeStamp
                content.subtitle = timeStamp
                content.sound = UNNotificationSound.default
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully")
                    }
                }
                showAlert = true
            }
            .alert(timeStamp, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
