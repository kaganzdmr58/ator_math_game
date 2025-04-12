enum PageType implements Enum {
  plusTen("Plus 10","+", 10, 20),
  minusTen("Minus 10","-", 10, 20),
  ;

  const PageType(
    this.name,
    this.symbol,
    this.firstNumber,
    this.secondNumber,
  );

  final String name;
  final String symbol;
  final int firstNumber;
  final int secondNumber ;

  int getResult(int first, int second) {
    switch (this) {
      case PageType.plusTen:
        return first + second;
      case PageType.minusTen:
        return first - second;
      default:
        return 0;
    }
  }
}
