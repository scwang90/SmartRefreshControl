# IOS 智能下拉刷新框架 - SmartRefreshControl

[![License](https://img.shields.io/badge/License%20-Apache%202-337ab7.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Arsenal](https://img.shields.io/badge/Pod%20-%20SmartRefresh-4cae4c.svg)](https://android-arsenal.com/details/1/6001)
[![Platform](https://img.shields.io/badge/Platform-IOS-f0ad4e.svg)](https://www.android.com)
[![Author](https://img.shields.io/badge/Author-scwang90-11bbff.svg)](https://github.com/scwang90)

## [English](art/gif/README_EN.md) | 中文

SmartRefreshControl 是 [SmartRefreshLayout](https://github.com/scwang90/SmartRefreshLayout) 的IOS版，和Android版在 `理念` 和 `外观` 上面保留相同的设计，但是由于 Android 和 IOS 两个系统的差别，IOS版本在功能使用和特性上与安卓版有所差别。刷新控件使用 ObjectiveC 语言编写，演示 DemoApp 使用 Swift 语言编写。 

目前 `SmartRefreshControl` 功能还不是很强大，也不太稳定，只是在界面层面实现了安卓版的功能。欢迎大家来体验与发现BUG，不推荐使用在正式项目中。


## 由来

大学毕业后我大部分时间从事安卓开发，在安卓版 `SmartRefresh` 大火之后，我开始转型 IOS 开发。到现在已经有三年的IOS开发经验，由于IOS上也还未有像  `SmartRefresh` 一样同一个开源库多种外观样式的刷新库，也想巩固自己所学的 IOS技能，我决定在闲暇之余把安卓 `SmartRefresh` 复刻到IOS平台来。经过一年多的努力总算初步完成了。

<!-- ## 特点功能:

 - 支持多点触摸
 - 支持淘宝二楼和二级刷新
 - 支持嵌套多层的视图结构 Layout (LinearLayout,FrameLayout...)
 - 支持所有的 View（AbsListView、RecyclerView、WebView....View）
 - 支持自定义并且已经集成了很多炫酷的 Header 和 Footer.
 - 支持和 ListView 的无缝同步滚动 和 CoordinatorLayout 的嵌套滚动 .
 - 支持自动刷新、自动上拉加载（自动检测列表惯性滚动到底部，而不用手动上拉）.
 - 支持自定义回弹动画的插值器，实现各种炫酷的动画效果.
 - 支持设置主题来适配任何场景的 App，不会出现炫酷但很尴尬的情况.
 - 支持设多种滑动方式：平移、拉伸、背后固定、顶层固定、全屏
 - 支持所有可滚动视图的越界回弹
 - 支持 Header 和 Footer 交换混用
 - 支持 AndroidX
 - 支持[横向刷新](https://github.com/scwang90/SmartRefreshHorizontal) -->

 <!-- - [属性文档](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_property.md)
 - [常见问题](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_faq.md)
 - [智能之处](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_smart.md)
 - [更新日志](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_update.md)
 - [博客文章](https://segmentfault.com/a/1190000010066071)
 - [源码下载](https://github.com/scwang90/SmartRefreshLayout/releases)
 - [多点触摸](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_multitouch.md)
 - [自定义Header](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_custom.md) -->

<!-- ## Demo
[下载 APK-Demo](https://github.com/scwang90/SmartRefreshLayout/raw/master/art/app-debug.apk)

![](https://github.com/scwang90/SmartRefreshLayout/raw/master/art/png_apk_rqcode.png) -->


#### 成品展示
|Delivery|Material|
|:---:|:---:|
|![](art/gif/header-delivery.gif)|![](art/gif/header-material.gif)|
|[Refresh-your-delivery](https://dribbble.com/shots/2753803-Refresh-your-delivery)|[MaterialHeader](https://developer.android.com/reference/android/support/v4/widget/SwipeRefreshLayout.html)|

|BezierRadar|BezierCircle|
|:---:|:---:|
|![](art/gif/header-radar.gif)|![](art/gif/header-circle.gif)|
|[Pull To Refresh](https://dribbble.com/shots/1936194-Pull-To-Refresh)|[Pull Down To Refresh](https://dribbble.com/shots/1797373-Pull-Down-To-Refresh)|

|FlyRefresh|DropBox|
|:---:|:---:|
|![](art/gif/header-fly.gif)|![](art/gif/header-drop.gif)|
|[FlyRefresh](https://github.com/race604/FlyRefresh)|[DropBoxHeader](#1)|

|Phoenix|Taurus|
|:---:|:---:|
|![](art/gif/header-phoenix.gif)|![](art/gif/header-taurus.gif)|
|[Yalantis/Phoenix](https://github.com/Yalantis/Phoenix)|[Yalantis/Taurus](https://github.com/Yalantis/Taurus)

|BattleCity|HitBlock|
|:---:|:---:|
|![](art/gif/header-game-tank.gif)|![](art/gif/header-game-block.gif)|
|[FunGame/BattleCity](https://github.com/Hitomis/FunGameRefresh)|[FunGame/HitBlock](https://github.com/Hitomis/FunGameRefresh)


|StoreHouse|WaveSwipe|
|:---:|:---:|
|![](art/gif/header-store.gif)|![](art/gif/header-wave.gif)|
|[CRefreshLayout](https://github.com/cloay/CRefreshLayout)|[WaveSwipeRefreshLayout](https://github.com/recruit-lifestyle/WaveSwipeRefreshLayout)


|Original|Classics|
|:---:|:---:|
|![](art/gif/header-original.gif)|![](art/gif/header-classics.gif)|
|[FlyRefresh](https://github.com/race604/FlyRefresh)|[ClassicsHeader](#1)|



## 简单用例

#### 1.在 `Podfile` 中添加依赖


```
pod 'SmartRefreshControl', '~> 0.0.8'
```

#### 2.在 `ViewControler` 中添加刷新头
```ObjectiveC
@interface UITableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;  
@property (strong, nonatomic) UIRefreshClassicsHeader *header;  //申明刷新头属性，必须，后面关闭刷新要用到

@end

@implementation UITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方式1: 初始化同时绑定事件
    [self setHeader:[UIRefreshClassicsHeader attach:self.tableView target:self action:@selector(onRefresh)]];

    //方式2: 先初始化，再绑定事件
    [self setHeader:[UIRefreshClassicsHeader attach:self.tableView]];
    [self.header addTarget:self action:@selector(onRefresh)];

    //方式2: 先创建，再绑定
    [self setHeader:[UIRefreshClassicsHeader new]];
    [self.header attach:self.tableView];
    [self.header addTarget:self action:@selector(onRefresh)];

}

@end

```

#### 3.添加刷新监听事件
```ObjectiveC

@implementation UITableViewController

- (void)onRefresh {
    [self.header finishRefresh]; //关闭刷新，可以改成请求网络，成功/失败之后再关闭刷新
}

@end

```

## 赞赏

如果你喜欢 SmartRefreshLayout 的设计，感觉 SmartRefreshLayout 帮助到了你，可以点右上角 "Star" 支持一下 谢谢！ ^_^
你也还可以扫描下面的二维码~ 请作者喝一杯咖啡。

![](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/pay_alipay.jpg?raw=true) ![](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/pay_wxpay.jpg?raw=true) ![](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/pay_tencent.jpg?raw=true)

> 如果希望捐赠之后能获得相关的帮助，可以选择加入下面的付费群来取代普通捐赠，付费群可以直接获得作者的直接帮助，与问题反馈。

如果在捐赠留言中备注名称，将会被记录到列表中~ 如果你也是github开源作者，捐赠时可以留下github项目地址或者个人主页地址，链接将会被添加到列表中起到互相推广的作用
[捐赠列表](https://github.com/scwang90/SmartRefreshLayout/blob/master/art/md_donationlist.md)

## 讨论

### QQ解决群 - 602537182 （付费）
#### 进群须知
自开群以来，还是有很多的朋友提出了很多问题，我也解决了很多问题，其中有大半问题是本库的Bug导致，也有些是使用者项目本
身的环境问题，这花费了我大量的时间，经过我的观察和测试，到目前为止，本库的bug已经越来越少，当然不能说完全没有，但是
已经能满足很大部分项目的需求。所以从现在起，我做出一个决定：把之前的讨论群改成解决群，并开启付费入群功能，专为解决大
家在使用本库时遇到的问题，不管是本库bug还是，特殊的项目环境导致（包含项目本身的bug）。
我也有自己的工作和娱乐时间，只有大家理解和支持我，我才能专心的为大家解决问题。不过用担心，我已经建立了另一个可以免费
进入的QQ讨论群。

### QQ讨论群 - 914275312 （新） 477963933 （满）  538979188 （满）
#### 进群须知
这个群，免费进入，大家可以相互讨论本库的相关使用和出现的问题，群主也会在里面解决问题，如果提出的问题，群成员不能帮助
解决，需要群主解决，但是要花费群主五分钟以上的时间（本库Bug除外），群主将不会解决这个问题，如果项目紧急，请付费进入解
决群解决（不过注意，付费群中群主会很认真很努力的解决问题，但也不能保证已经能完美解决）或者转换使用其他的刷新库。

加入群的答案在本文档中可以找到~

## 其他作品
[MultiWaveHeader](https://github.com/scwang90/MultiWaveHeader)  
[SmartRefreshHorizontal](https://github.com/scwang90/SmartRefreshLayout)  
[SmartRefreshHorizontal](https://github.com/scwang90/SmartRefreshHorizontal)  
[诗和远方](http://android.myapp.com/myapp/detail.htm?apkName=com.poetry.kernel)  

## 感谢
[SwipeRefreshLayout](https://developer.android.com/reference/android/support/v4/widget/SwipeRefreshLayout.html)  
[Ultra-Pull-To-Refresh](https://github.com/liaohuqiu/android-Ultra-Pull-To-Refresh)  
[TwinklingRefreshLayout](https://github.com/lcodecorex/TwinklingRefreshLayout)  
[BeautifulRefreshLayout](https://github.com/android-cjj/BeautifulRefreshLayout)

License
-------

    Copyright 2017 scwang90

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.