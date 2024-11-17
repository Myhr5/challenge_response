String getErrors(String value) {
  switch (value) {
    case 'Minimum 8 characteres':
      return 'errorMinimumChar';
    case 'Must have a digit':
      return 'errorMinimumDigit';
    case 'Must have a lower char':
      return 'errorLowerChar';
    case 'Must have an uppercase char':
      return 'errorUpperChar';
    case 'Must have a special char':
      return 'errorSpecialChar';
  }

  return '';

}
