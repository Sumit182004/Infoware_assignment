import 'package:flutter_bloc/flutter_bloc.dart';

// Form Events
abstract class FormEvent {}

class SubmitFormEvent extends FormEvent {}

// Form States
abstract class FormState {}

class FormInitial extends FormState {}

class FormSubmitted extends FormState {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String state;
  final String city;

  FormSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}

class FormError extends FormState {
  final String error;

  FormError(this.error);
}

// Form BLoC
class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormInitial());

  @override
  Stream<FormState> mapEventToState(FormEvent event) async* {
    if (event is SubmitFormEvent) {
      // Handle form submission here
      yield FormSubmitted(
        name: "Name",
        email: "email@example.com",
        phone: "1234567890",
        gender: "Male",
        country: "Country",
        state: "State",
        city: "City",
      );
    }
  }
}
