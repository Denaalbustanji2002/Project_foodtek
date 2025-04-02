class  BannerModel {
  int? id;
  String? imageurl;

  BannerModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    imageurl = data['imageurl'];

  }
}