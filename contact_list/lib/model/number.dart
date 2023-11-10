
enum NumberTypes {
  Mobile,
  Phone,
  Work,
  Main,
  Fax,
  Pager,
  Custom,
  Other,
}

class NumberList {
 const NumberList(this.typeName, this.digit);
  final NumberTypes typeName;
  final String digit;
}
