import 'package:flutter/material.dart';

// import 'package:device_calendar/device_calendar.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/fleet_calendar.dart';

// class FleetEvent {
//   final String id;
//   final String vehicleName;
//   final String eventType; // "Maintenance", "Repair", "Inspection"
//   final DateTime date;
//   final String notes;

//   FleetEvent({
//     required this.id,
//     required this.vehicleName,
//     required this.eventType,
//     required this.date,
//     this.notes = '',
//   });
// }


// final _deviceCalendarPlugin = DeviceCalendarPlugin();

// Future<void> addToCalendar(FleetEvent event) async {
//   // Request permission
//   var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
//   if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
//     await _deviceCalendarPlugin.requestPermissions();
//   }

//   // Retrieve calendars
//   var calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
//   final calendar = calendarsResult.data!.first; // pick default calendar

//   // Create calendar event
//   final calendarEvent = Event(
//     calendar.id,
//     title: '${event.vehicleName} - ${event.eventType}',
//     start: event.date,
//     end: event.date.add(const Duration(hours: 1)),
//     description: event.notes,
//   );

//   await _deviceCalendarPlugin.createOrUpdateEvent(calendarEvent);
// }

class FleetMaintenanceScreen extends StatefulWidget {
  final AppService service = getIt<AppService>();

  FleetMaintenanceScreen({super.key});

  @override
  State<FleetMaintenanceScreen> createState() => _FleetMaintenanceScreenState();
}

class _FleetMaintenanceScreenState extends State<FleetMaintenanceScreen> {
  late Future<List<FleetEvent>> _eventsFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _refreshEvents();
  }

  void _refreshEvents() {
    _eventsFuture = widget.service.fleet.getFutureEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fleet Maintenance')),
      body: FutureBuilder<List<FleetEvent>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final events = snapshot.data!;
          if (events.isEmpty) {
            return const Center(child: Text('No upcoming events.'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (_, i) {
              final e = events[i];
              return ListTile(
                title: Text('${e.vehicleName} - ${e.eventType}'),
                subtitle: Text('${e.date.toLocal()} • ${e.notes ?? ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await widget.service.fleet.deleteEvent(e);
                    setState(_refreshEvents);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit screen
          Navigator.push(
            context, // 'context' must be available in the widget tree
            MaterialPageRoute(builder: (context) => AddEditFleetEventScreen(service: widget.service.fleet)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}