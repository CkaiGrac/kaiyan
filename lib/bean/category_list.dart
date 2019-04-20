import '../bean/Category.dart';
/*
 * @Created Date: 2019-02-07 12:03
 * @Author: Ckai
 * @Description: 
 */

class CategoryList {
  final List<Category> categorys;

  CategoryList({
    this.categorys,
  });

  factory CategoryList.fromJson(List<dynamic> paresedJson) {
    List<Category> categorys = new List<Category>();
    categorys = paresedJson.map((i) => Category.fromJson(i)).toList();

    return new CategoryList(categorys: categorys);
  }
}
