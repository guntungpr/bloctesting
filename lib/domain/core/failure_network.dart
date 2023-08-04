import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_network.freezed.dart';

@freezed
class FailureNetwork with _$FailureNetwork {
  const factory FailureNetwork.serverError() = _ServerError;
  const factory FailureNetwork.noInternet() = _NoInternet;
  const factory FailureNetwork.failure({String? message}) = _Failure;
}
