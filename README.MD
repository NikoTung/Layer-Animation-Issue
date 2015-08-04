## iOS 动画

这只是一个简单的验证了一下在 iOS 的动画中并没有真正的改变`Layer`的一些属性。

在`CALayer`中有一个叫`presentationLayer`的一些属性。
	
>The layer object returned by this method provides a close approximation of the layer that is currently being displayed onscreen. While an animation is in progress, you can retrieve this object and use it to get the current values for those animations.

这就是说这返回这个跟我们实际操作的`layer`极度相似的`layer`对象。并且在动画的作用过程中，我们通过这个对象可以查看到`layer`的实时属性变化。

在一个动画中，通过`CAAnimation`的子类，如：`CAPropertyAnimation`,`CAKeyframeAnimation`和`CABasicAnimation`创建一个动画对象，对这个动画对象的一些属性的设置来定义动画的形式等，最后把这个动画 add 到 layer 上。这样我们就能看到 layer 的动画。能看到了动画，直观来说我们都认为 layer 的某些属性被改变了，所以认为是动画改变了 layer ，然而并不是这样的。

	var animation = CABasicAnimation(keyPath: "position.y")
	animation.toValue = 300.0
	animation.duration = 1.0;
	layer.addAnimation(animation, forKey: "positionAnimation")

上面这样的一个动画，最后完成后，layer 会瞬间返回到原来的位置。这就跟我们的认知对不上了。

> An app using Core Animation has three sets of layer objects. Each set of layer objects has a different role in making the content of your app appear onscreen:

>Objects in the model layer tree (or simply “layer tree”) are the ones your app interacts with the most. The objects in this tree are the model objects that store the target values for any animations. Whenever you change the property of a layer, you use one of these objects.
Objects in the presentation tree contain the in-flight values for any running animations. Whereas the layer tree objects contain the target values for an animation, the objects in the presentation tree reflect the current values as they appear onscreen. You should never modify the objects in this tree. Instead, you use these objects to read current animation values, perhaps to create a new animation starting at those values.
Objects in the render tree perform the actual animations and are private to Core Animation.
















https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreAnimation_guide/CoreAnimationBasics/CoreAnimationBasics.html#//apple_ref/doc/uid/TP40004514-CH2-SW13