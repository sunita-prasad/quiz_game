import 'package:equatable/equatable.dart';

class OptionsState extends Equatable {
  final bool isValid;

  @override
  List<Object?> get props => [this.isValid];

  const OptionsState({required this.isValid});
}
