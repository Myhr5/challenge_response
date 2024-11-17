String getErrors(String value) {
  switch (value) {
    case 'Minimum 8 characteres':
      return 'minimumChar';
    case 'Must have a digit':
      return 'minimumDigit';
    case 'Must have a lower char':
      return 'lowerChar';
    case 'Must have an uppercase char':
      return 'upperChar';
    case 'Must have a special char':
      return 'specialChar';
  }

  return '';
}
