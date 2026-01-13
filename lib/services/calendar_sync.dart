import 'dart:io' show Platform;
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;

/// Abstract calendar sync; use factory to get platform-specific impl.
abstract class CalendarSync {
  /// Upsert an event; return external calendar event id (if any).
  Future<String?> upsertEvent({
    required String title,
    required DateTime start,
    required DateTime end,
    String? notes,
    String? externalId,
  });

  Future<void> deleteEvent(String externalId);

  factory CalendarSync() {
    if (Platform.isIOS || Platform.isAndroid) return _MobileCalendarSync();
    if (Platform.isMacOS) return _MacCalendarSync();
    return const _NoopCalendarSync();
  }
}

class _MobileCalendarSync implements CalendarSync {
  final DeviceCalendarPlugin _plugin = DeviceCalendarPlugin();
  String? _calendarId;

  Future<void> _ensure() async {
    final has = await _plugin.hasPermissions();
    if (!(has.isSuccess && (has.data ?? false))) {
      final req = await _plugin.requestPermissions();
      if (!(req.isSuccess && (req.data ?? false))) {
        throw Exception('Calendar permission denied');
      }
    }
    if (_calendarId == null) {
      final calendars = await _plugin.retrieveCalendars();
      if (!calendars.isSuccess || calendars.data == null || calendars.data!.isEmpty) {
        throw Exception('No calendar available');
      }
      _calendarId = calendars.data!.first.id;
    }
  }

  @override
  Future<String?> upsertEvent({
    required String title,
    required DateTime start,
    required DateTime end,
    String? notes,
    String? externalId,
  }) async {
    await _ensure();
    final tzStart = tz.TZDateTime.from(start, tz.local);
    final tzEnd = tz.TZDateTime.from(end, tz.local);
    final event = Event(
      _calendarId!,
      eventId: externalId,
      title: title,
      start: tzStart,
      end: tzEnd,
      description: notes,
    );
    final res = await _plugin.createOrUpdateEvent(event);
    if (!(res?.isSuccess ?? false)) {
      throw Exception('Calendar upsert failed');
    }
    return res?.data;
  }

  @override
  Future<void> deleteEvent(String externalId) async {
    await _ensure();
    await _plugin.deleteEvent(_calendarId!, externalId);
  }
}

class _MacCalendarSync implements CalendarSync {
  static const _channel = MethodChannel('com.hammerops/calendar');

  @override
  Future<String?> upsertEvent({
    required String title,
    required DateTime start,
    required DateTime end,
    String? notes,
    String? externalId,
  }) async {
    final res = await _channel.invokeMethod<String>('upsertEvent', {
      'title': title,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'notes': notes,
      'eventId': externalId,
    });
    return res;
  }

  @override
  Future<void> deleteEvent(String externalId) async {
    await _channel.invokeMethod('deleteEvent', {'eventId': externalId});
  }
}

class _NoopCalendarSync implements CalendarSync {
  const _NoopCalendarSync();

  @override
  Future<String?> upsertEvent({
    required String title,
    required DateTime start,
    required DateTime end,
    String? notes,
    String? externalId,
  }) async {
    return null;
  }

  @override
  Future<void> deleteEvent(String externalId) async {}
}
