import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/blocs/form_bloc.dart' as form_bloc;

class FormScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<form_bloc.FormBloc>().add(form_bloc.SubmitFormEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => form_bloc.FormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Form Screen"),
        ),
        body: BlocBuilder<form_bloc.FormBloc, form_bloc.FormState>(
          builder: (context, state) {
            if (state is form_bloc.FormSubmitted) {
              return const Center(child: Text("Form submitted successfully"));
            } else if (state is form_bloc.FormError) {
              return Center(child: Text("Error: ${state.error}"));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTextField(_nameController, 'Name'),
                        _buildTextField(_emailController, 'Email', isEmail: true),
                        _buildTextField(_phoneController, 'Phone', isPhone: true),
                        _buildTextField(_genderController, 'Gender'),
                        _buildTextField(_countryController, 'Country'),
                        _buildTextField(_stateController, 'State'),
                        _buildTextField(_cityController, 'City'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _submitForm(context),
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isEmail = false, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
        keyboardType: isPhone
            ? TextInputType.phone
            : isEmail
            ? TextInputType.emailAddress
            : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          if (isPhone) {
            if (value.length < 10) {
              return 'Phone number must be at least 10 digits';
            }
            // Check if the phone number starts with 7, 8, or 9
            if (!RegExp(r'^[789]').hasMatch(value)) {
              return 'Phone number must start with 7, 8, or 9';
            }
          }
          return null;
        },
      ),
    );
  }
}
