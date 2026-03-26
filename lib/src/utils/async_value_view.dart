import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/widgets/error_view.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';

class AsyncValueView<T> extends ConsumerWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.builder,
  });
  final AsyncValue<T> value;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: builder,
      error: (error, stackTrace) => ErrorView(
        error: error,
        stackTrace: stackTrace,
      ),
      loading: () => const LoadingSpinner(),
    );
  }
}
