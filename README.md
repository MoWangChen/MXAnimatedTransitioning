# MXAnimatedTransitioning
自定义转场动画效果

## 转场效果
- **侧边栏效果：MXAnimatedSegueTypeSlider**
	
	<img src="http://i4.piimg.com/6a45360d084020cc.gif" height="568" width="320" />
	
	
- **窗户效果：MXAnimatedSegueTypeWindow**

	<img src="http://i3.piimg.com/abb588f73897024b.gif" height="568" width="320" />

	
##用法:
1.将`MXTransition`文件夹拖入到工程中

2.控制器继承于`MXRootViewController`

	#import "MXRootViewController.h"

	@interface AViewController : MXRootViewController

	@end
	
	
3.设置跳转效果的枚举值

	AViewController *aVC = [AViewController new];
	
   	aVC.MXType = MXAnimatedSegueTypeSlider;
   	
  	[self presentViewController:aVC animated:YES completion:nil];
  	
  	
##项目内容介绍
要实现present、dismiss自定义转场动画，就必须要遵守UIViewControllerAnimatedTransitioning协议，并实现其代理方法。

此时，我们将代理方法放入父类`MXRootViewController`中去执行，转场动画的自定义效果制作使用(id < UIViewControllerContextTransitioning >）的NSObject类`MXAnimatedTransiton`来实现。
	
	
  	
  	
##具体实例请下载项目

有问题随时issue或者邮箱<xiepengxiang93@sina.com>联系我.