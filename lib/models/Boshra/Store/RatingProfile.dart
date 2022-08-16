
import 'RatingModel.dart';

class RatingProfile {
  var shop_name,
      brand,
      image,
      review,
      num_sales_last_month,
      num_sales_befor_2month,
      num_sales_befor_3month,
      good_last_month,
      bad_last_month,
      smile_last_month,
      good_last_2month,
      bad_last_2month,
      smile_last_2month,
      good_last_3month,
      bad_last_3month,
      smile_last_3month;

  factory RatingProfile.fromJson(Map<String, dynamic> json) {
    return RatingProfile(
        shop_name: json['store_name'],
        brand: json['brand'],
        image: json['image'],
        review: json['review'],
        num_sales_last_month: json['num_sales_last_month'],
        num_sales_befor_2month: json['num_sales_befor_2month'],
        num_sales_befor_3month: json['num_sales_befor_3month'],
        good_last_month: json['good_last_month'],
        bad_last_month: json['bad_last_month'],
        smile_last_month: json['smile_last_month'],
        good_last_2month: json['good_last_2month'],
        bad_last_2month: json['bad_last_2month'],
        smile_last_2month: json['smile_last_2month'],
        good_last_3month: json['good_last_3month'],
        bad_last_3month: json['bad_last_3month'],
        smile_last_3month: json['smile_last_3month']);
  }

  RatingProfile(
      {required this.shop_name,
      required this.brand,
      required this.image,
      required this.review,
      required this.num_sales_last_month,
      required this.num_sales_befor_2month,
      required this.num_sales_befor_3month,
      required this.good_last_month,
      required this.bad_last_month,
      required this.smile_last_month,
      required this.good_last_2month,
      required this.bad_last_2month,
      required this.smile_last_2month,
      required this.good_last_3month,
      required this.bad_last_3month,
      required this.smile_last_3month});
}

class RatingProfileModel {
  List<RatingProfile> data;

  RatingProfileModel({required this.data});

  factory RatingProfileModel.fromJson(Map<String, dynamic> json) {
    return RatingProfileModel(
        data: List<RatingProfile>.from(
            json['data'].map((p) => RatingProfile.fromJson(p))).toList());
  }
}
