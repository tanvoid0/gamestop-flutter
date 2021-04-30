String nameValidator(value) {
  if (value.isEmpty) {
    return "Invalid name";
  }
}

String emailValidator(value) {
  if (value.isEmpty || !value.contains('@')) {
    return 'Invalid email!';
  }
  return null;
}

String passwordValidator(value) {
  if (value.isEmpty || value.length < 5) {
    return 'Password is too short!';
  }
  return null;
}

String password2Validator(value1, value2) {
  if (value1 != value2) {
    return "Passwords do not match";
  }
  return null;
}
