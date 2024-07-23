String formatDate(String dateString) {
  try {
    final DateTime date = DateTime.parse(dateString);
    final String formattedDate = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return formattedDate;
  } catch (e) {
    // Handle errors in parsing the date
    print('Error formatting date: $e');
    return dateString; // Return the original string if formatting fails
  }
}