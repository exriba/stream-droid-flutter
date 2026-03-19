import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

final clientChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    constants.serverName,
    port: constants.serverPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      // TODO: Use secure credentials for production
    ),
  );
  return channel;
});
