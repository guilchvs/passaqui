String formatPhoneNumber(String phoneNumber) {
  try {
    // Remove any non-digit characters
    final cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if the number has the correct length (11 digits)
    if (cleaned.length == 11) {
      // Format as (11) 12345-1234
      final areaCode = cleaned.substring(0, 2);
      final firstPart = cleaned.substring(2, 7);
      final secondPart = cleaned.substring(7);
      return '($areaCode) $firstPart-$secondPart';
    } else {
      // Return the cleaned number if it doesn't match the expected length
      return phoneNumber;
    }
  } catch (e) {
    // Handle errors
    print('Error formatting phone number: $e');
    return phoneNumber; // Return the original string if formatting fails
  }
}