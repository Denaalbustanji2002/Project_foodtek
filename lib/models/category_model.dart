class CategoryModel {
  int? id;
   String? name;
   String? icon;

  CategoryModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    icon = data['icon'];
  }
}