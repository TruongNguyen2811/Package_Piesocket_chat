import 'package:equatable/equatable.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState();

  @override
  List<Object> get props => [];
}

class ChatDetailInitial extends ChatDetailState {}

class ChatDetailLoading extends ChatDetailState {}

class ChatDetailFailure extends ChatDetailState {
  final String messageError;

  const ChatDetailFailure({required this.messageError});
}

class ChatDetailGetDataSuccess extends ChatDetailState {}

class UpdateMessage extends ChatDetailState {}
