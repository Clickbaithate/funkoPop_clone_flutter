// ignore_for_file: avoid_print

class FunkoPop {

  String name;
  String series;
  String image;
  bool liked;
  bool wishlist;

  FunkoPop(this.name, this.series, this.image, this.liked, this.wishlist);

  void printFunko() {
    print("NAME: $name, SERIES: $series, LIKED?: $liked, WISHLIST?: $wishlist");
  }

}