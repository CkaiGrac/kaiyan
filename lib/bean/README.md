##### "这个目录下怎么这么多文件？是不是疯了？"
其实这个目录下得所有*.g.dart文件都是由``json_serializable``和``json_annotation``这两个官方插件自动生成的，这个项目数据接口比较复杂，嵌套比较严重，最终就成这个样子了。
**稍微介绍一下如何使用这两个插件：**

**第一步：在``pubspec.yaml``文件中声明这两个插件**
```yaml
dependencies:
  flutter:
    sdk: flutter

  json_annotation: ^2.0.0
 
dev_dependencies:
  build_runner: ^1.1.3
  flutter_test:
    sdk: flutter

  json_serializable: ^2.0.1
```
然后运行``flutter packages get``命令加载这两个插件

**第二步：根据json数据编写实体类：**

假如我们请求得到这样的json数据：
```json
{
    "data": {

        "header": {
            "id": 12,
            "title": "最近更新",
            "font": "normal",
            "subTitle": null,
        },

        "xxxx":{},
        .......
    }
}
```
可以明显看出data属性包含着header属性，而header又有自己的属性
这时我们可以从最里面的header属性开始写起：
```dart
///一定要倒入这个包
import 'package:json_annotation/json_annotation.dart';
///这个就是生成*.g.dart由来
part 'Header.g.dart';

@JsonSerializable() ///一定要写这个
class Header {
    int id;
    String title;
    String font;
    var subTitle;

Header({
    this.id,
    this.title,
    this.font,
    this.subTitle,
  });

///工厂方法，插件会自动在*.g.dart文件中生成[fromJson]和[toJson]
///这两个方法用于json数据的序列化和反序列化
factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
}
```
找规律，json数据有什么属性就定义什么变量，属性名称和变量名称要一致，当不清楚变量要什么类型的时候就用var来自动类型推断。

然后data属性就可以按照上面这种写法，大同小异：
```dart
///一定要倒入这个包
import 'package:json_annotation/json_annotation.dart';
///这个就是生成*.g.dart由来
part 'Data.g.dart';

@JsonSerializable() ///一定要写这个
class Data {
    Header header;
    .....
Header({
    this.header,
  });

///工厂方法，插件会自动在*.g.dart文件中生成[fromJson]和[toJson]
///这两个方法用于json数据的序列化和反序列化
factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
```
可以看到没什么大区别，这样也解决了嵌套的问题。
还没完。

**第三步：**

当写完这两个文件之后会发现，这两个全都红色报错了，还需要运行这个命令来生成 *.g.dart文件
<<<<<<< HEAD
=======

``flutter packages pub run build_runner build``
>>>>>>> 695c33c52a0eff77ac925672ec7fc10f7fec264b

``flutter packages pub run build_runner build``

