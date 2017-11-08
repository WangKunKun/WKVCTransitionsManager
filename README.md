#VC转场模板

##解决问题：

App如今的功能性以及趋向与完善、饱和，人们越加重视在app中的体验，本模板主要解决vc转场方法类的封装，便于书写转场动画，只需要继承WKBaseAnimator类，实现present和dismiss方法，再为利用demo中类目为vc的animator类赋值，运用原生推送即可得到转场效果，不需要再去担心转场代理相关的信息。

##使用方式:

1. 在项目中引入demo中transitions以及tools文件夹。

2. 将transtions中的类目文件UINavigationController+WKTransitions以及UIViewController+WKTransitions加入全局定义文件pch中。
	
3. 继承WKBaseAnimator类，实现present和dismiss方法，在其中自定义动画转场。

4. 将写好的动画类赋值到VC的拓展属性wk_modelAnimator(模态转场)以及wk_navAnimator(导航转场)
	
5. 使用原生的模态推送或者导航推送方法即可。
	
	ps:demo中的animator文件夹已经实现了几个基本的转场动画便于参考使用·
	
##效果展示

![](转场.gif)

##封装思路

转场动画主要在于代理的实现以及动画的书写。
	
代理对应WKAnimatorManager类，动画基类对应WKBaseAnimator。
	
在实际过程中，在navc和vc的类目中已经将WKAnimatorManager设为了转场代理~WKBaseAnimator 实现转场内容，实际实现继承自WKBaseAnimator，实现dismiss和present方法即可
	




	
