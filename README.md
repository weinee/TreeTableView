# TreeTableView
===
##一、简介
当前对原仓库做了扩展，增加了通用性，可以传入自定义cell。
（原仓库简介）：
树形控件在多列列表、多级菜单中使用比较常见，比如：国家-省份-城市 多级选择、学校-专业-班级 多级选择等等。然而IOS自带控件中并不存在树形控件，我们要在IOS开发中使用树形控件，通常需要自己扩展UITableView列表控件。<br/>现在在这里开源一个自己写的高扩展性，高复用性的IOS树形结构控件。<br/>支持无限极树形结构。<br/>使用的是非递归方式。<br/>代码简单易懂，扩展方便。<br/>图片演示如下：
![项目演示](http://img.my.csdn.net/uploads/201507/05/1436079831_2869.gif)
<br/>
<br/>
##二、使用说明
###第一步：建立数据模型, 自定义的数据模型要继承这个类
parentId ： 该节点的父控件id号，如果为-1则表示该节点为根节点<br/>
nodeId ： 每个节点自身的id号，是每个节点的唯一标示<br/>
name ： 节点的名称<br/>
depth ： 该节点所带的树形结构中的深度，根节点的深度为0<br/>
expand ： 该节点是否处于展开状态<br/>
```
/**
*  每个节点类型
*/
@interface TreeNodeModel : NSObject

@property (nonatomic , assign) int parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) int nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@end
```
###第二步：按照以上的数据模型，组装数据，demo中以 国家-身份-城市 的三级目录进行演示。


###第三步：使用以上数据进行TeeTableView的初始化。

```
TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) withData:data];
//然后可以配置自定义cell
[self.view addSubview:tableview];
```
通过简单以上三步，你就可以把该树形控件集成到你的项目中。
<br/>
<br/>
##三、实现原理
树形结构的列表用的其实就是UITableView控件，但是如何能够让UItableView能够动态的增加和删除指定的行数的cell是实现树形结构的关键所在。
这时候我们需要用到两个UItableView自带的行数：
```
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
```
第一个函数用来在指定的位置插入cells，第二个函数用来在指定的位置删除cells，并且这二个函数都自带多种动画效果，让删除和插入的过程不至于太突兀、有种渐变的感觉，具有良好的用户体验。
对于这几个动画做了尝试：
UITableViewRowAnimationFade ： 渐变效果
UITableViewRowAnimationRight ： 右边进入，右边消失
UITableViewRowAnimationLeft ： 左边进入，左边消失
UITableViewRowAnimationTop ： 顶部进入，顶部消失
UITableViewRowAnimationBottom ： 顶部进入，底部消失

###<font color=red>注意点：</font>
在调用insertRowsAtIndexPaths和deleteRowsAtIndexPaths的时候一定要先改变数据源，在调用上述函数，不然会产生crash。


<br/>
##四、总结
在演示项目中，每个cell我都使用系统自带的cell，样式比较简单，如果你要展现更加漂亮的样式，可以自定义cell。<br/>
同时，你也可以扩展该数据模型，运动到更加复杂的业务处理中。比如以下场景：
![这里写图片描述](http://img.my.csdn.net/uploads/201507/05/1436079894_7992.gif)
<br/>
##五、下载地址
github原仓库下载地址：[https://github.com/yixiangboy/TreeTableView](https://github.com/yixiangboy/TreeTableView)<br/>
如果觉得对你还有些用，给一颗star吧。你的支持是我继续的动力。<br/>
<br/>
