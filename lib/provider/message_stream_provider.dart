import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rablochatapp/data/modal/message_data.dart';
import 'package:rablochatapp/repo/message_repo.dart';


// Define the provider
final messageStreamProvider =
    StreamProvider.autoDispose<Iterable<MessageData>>((ref) {
  return ref.watch(messageRepoProvider).getAllMessages();
});
