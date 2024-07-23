String formatCpf(String cpf) {
  // Remove any non-digit characters
  final digitsOnly = cpf.replaceAll(RegExp(r'\D'), '');

  if (digitsOnly.length <= 3) {
    return digitsOnly;
  } else if (digitsOnly.length <= 6) {
    return '${digitsOnly.substring(0, 3)}.${digitsOnly.substring(3)}';
  } else if (digitsOnly.length <= 9) {
    return '${digitsOnly.substring(0, 3)}.${digitsOnly.substring(3, 6)}.${digitsOnly.substring(6)}';
  } else {
    return '${digitsOnly.substring(0, 3)}.${digitsOnly.substring(3, 6)}.${digitsOnly.substring(6, 9)}-${digitsOnly.substring(9, 11)}';
  }
}