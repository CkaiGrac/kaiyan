## 使用flutter_splash_screen插件为android和ios端添加app启动页
### 使用方式：
**1. 添加依赖：**
```yaml
dependencies:
  flutter_splash_screen: ^0.1.0
```
```
$ flutter packages get
```
**2. Android端配置**

在``/android/app``下的``MainActivity.java``添加一行：
```java
public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
 +       SplashScreen.show(this, true);// here
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
    }
}
```
然后在``android/app/src/main/res/layout``下的layout文件夹中创建``launch_screen.xml``启动页布局文件。（如果layout文件夹不存在，则手动创建）

接着在xml布局文件中就可以随心所欲的设置启动也了，动画播放这个还不清楚怎么实现。

比如我这个项目这么写的:
```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
     android:layout_width="match_parent"
     android:layout_height="match_parent"
     android:orientation="vertical">

     <ImageView
          android:layout_width="match_parent"
          android:layout_height="match_parent"
          android:scaleType="centerCrop"
          android:src="@mipmap/landing_background" />

     <ImageView
          android:id="@+id/icon"
          android:layout_width="wrap_content"
          android:layout_height="wrap_content"
          android:layout_centerInParent="true"
          android:src="@mipmap/ic_account_login_header" />

     <ImageView
          android:id="@+id/slogan"
          android:layout_width="wrap_content"
          android:layout_height="wrap_content"
          android:layout_alignParentBottom="true"
          android:layout_centerHorizontal="true"
          android:layout_marginBottom="50dp"
          android:src="@mipmap/ic_slogan" />

     <TextView
          android:layout_width="wrap_content"
          android:layout_height="wrap_content"
          android:layout_alignParentBottom="true"
          android:layout_centerHorizontal="true"
          android:text="每日精选视频推介，让你大开眼界。"
          android:textSize="10sp"
          android:layout_marginBottom="30dp"
          android:textColor="#d6d6d6" />
</RelativeLayout>
```

<div align="center">
<img src="/screenshot/splash_android.png"  height="350" width="200">
</div>

**3. IOS端**
待续