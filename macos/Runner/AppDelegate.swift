import Cocoa
import FlutterMacOS
import EventKit

@main
class AppDelegate: FlutterAppDelegate {
  private let calendarChannelName = "com.hammerops/calendar"
  private let eventStore = EKEventStore()

  override func applicationDidFinishLaunching(_ notification: Notification) {
    let controller: FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: calendarChannelName, binaryMessenger: controller.engine.binaryMessenger)

    channel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { return }
      switch call.method {
      case "upsertEvent":
        guard
          let args = call.arguments as? [String: Any],
          let title = args["title"] as? String,
          let startStr = args["start"] as? String,
          let endStr = args["end"] as? String,
          let start = ISO8601DateFormatter().date(from: startStr),
          let end = ISO8601DateFormatter().date(from: endStr)
        else {
          result(FlutterError(code: "BAD_ARGS", message: "Invalid arguments", details: nil))
          return
        }
        let notes = args["notes"] as? String
        let eventId = args["eventId"] as? String
        self.upsertEvent(title: title, start: start, end: end, notes: notes, eventId: eventId, result: result)
      case "deleteEvent":
        guard
          let args = call.arguments as? [String: Any],
          let eventId = args["eventId"] as? String
        else {
          result(FlutterError(code: "BAD_ARGS", message: "Invalid arguments", details: nil))
          return
        }
        self.deleteEvent(eventId: eventId, result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    super.applicationDidFinishLaunching(notification)
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  private func requestAccessIfNeeded(completion: @escaping (Bool) -> Void) {
    switch EKEventStore.authorizationStatus(for: .event) {
    case .authorized:
      completion(true)
    case .notDetermined:
      eventStore.requestAccess(to: .event) { granted, _ in
        DispatchQueue.main.async { completion(granted) }
      }
    default:
      completion(false)
    }
  }

  private func upsertEvent(title: String, start: Date, end: Date, notes: String?, eventId: String?, result: @escaping FlutterResult) {
    requestAccessIfNeeded { granted in
      guard granted else {
        result(FlutterError(code: "NO_PERMISSION", message: "Calendar access denied", details: nil))
        return
      }
      let calendar: EKCalendar
      if let defaultCalendar = self.eventStore.defaultCalendarForNewEvents {
        calendar = defaultCalendar
      } else if let first = self.eventStore.calendars(for: .event).first {
        calendar = first
      } else {
        result(FlutterError(code: "NO_CALENDAR", message: "No calendars available", details: nil))
        return
      }

      let event: EKEvent
      if let id = eventId, let existing = self.eventStore.event(withIdentifier: id) {
        event = existing
      } else {
        event = EKEvent(eventStore: self.eventStore)
        event.calendar = calendar
      }

      event.title = title
      event.startDate = start
      event.endDate = end
      event.notes = notes

      do {
        try self.eventStore.save(event, span: .thisEvent)
        result(event.eventIdentifier)
      } catch {
        result(FlutterError(code: "SAVE_FAILED", message: error.localizedDescription, details: nil))
      }
    }
  }

  private func deleteEvent(eventId: String, result: @escaping FlutterResult) {
    requestAccessIfNeeded { granted in
      guard granted else {
        result(FlutterError(code: "NO_PERMISSION", message: "Calendar access denied", details: nil))
        return
      }
      guard let event = self.eventStore.event(withIdentifier: eventId) else {
        result(nil) // already gone
        return
      }
      do {
        try self.eventStore.remove(event, span: .thisEvent)
        result(nil)
      } catch {
        result(FlutterError(code: "DELETE_FAILED", message: error.localizedDescription, details: nil))
      }
    }
  }
}
