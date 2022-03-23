class Coin {
  final int rank;
  final String name;
  final String symbol;
  final String price; // type double throwed an error?
  final String priceChange24h;
  final String image;

  Coin(
    this.rank,
    this.name,
    this.symbol,
    this.price,
    this.priceChange24h,
    this.image,
  );
}
