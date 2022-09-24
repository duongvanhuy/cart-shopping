class Rating {
  num? rate;
  int? count;
  // contractor
  Rating({this.rate, this.count});
  // function from json
  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }
}
