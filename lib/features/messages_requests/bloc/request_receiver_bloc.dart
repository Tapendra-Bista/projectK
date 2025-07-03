import 'package:afriqueen/features/messages_requests/model/request_model.dart';
import 'package:afriqueen/features/messages_requests/repository/request_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_receiver_bloc.freezed.dart';
part 'request_receiver_event.dart';
part 'request_receiver_state.dart';

class RequestReceiverBloc
    extends Bloc<RequestReceiverEvent, RequestReceiverState> {
  final RequestRepository _requestsRepository;

  RequestReceiverBloc({required RequestRepository repository})
      : _requestsRepository = repository,
        super(RequestReceiverState.initial()) {
    on<RequestReceiverGet>(_onMessageRequestsGet);
    on<RequestReceiverUnreadCount>(_onMessageRequestsUnreadCount);
  }

  // Requests Get
  Future<void> _onMessageRequestsGet(
      RequestReceiverGet event, Emitter<RequestReceiverState> emit) async {
    try {
      final List<Requestmodel> getTotalRequests =
          await _requestsRepository.fetchRequests();
      if (getTotalRequests.isEmpty) {
        emit(RequestReceiverState.noRequestsYet());
      } else {
        emit(RequestReceiverState.getRequests(receiverData: getTotalRequests));
      }
      await _requestsRepository.markAsRead();
    } catch (e) {
      print("Error in Requests fetch !");
      emit(RequestReceiverState.errorInRequests(errorMessage: e.toString()));
    }
  }

  // Unread requests
  Future<void> _onMessageRequestsUnreadCount(RequestReceiverUnreadCount event, 
      Emitter<RequestReceiverState> emit) async {
    final count = await _requestsRepository.unReadRequests();
    emit(RequestReceiverState.getUnreadCount(count: count));
    print("Unread requests are $count");
  }
}
