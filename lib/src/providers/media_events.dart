import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/event_service.dart';

part 'media_events.g.dart';

@riverpod
EventService eventService(EventServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return EventService(clientChannel, authInterceptor);
}
