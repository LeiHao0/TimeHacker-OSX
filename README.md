
##时间统计法
最早记录 ，是从 [奇特的一生](http://book.douban.com/subject/1115353/) 开始的  
大致是说，主角 柳比歇夫 一生完成了不可思议的工作量，对于时间，有近乎直觉的敏感  

一般来说，我们陷入 [心流(ZONE)](http://zh.wikipedia.org/zh/%E5%BF%83%E6%B5%81%E7%90%86%E8%AB%96) （翻译成 领域 多好） 的时候，往往是觉察不到时间流逝的，即 主观时间 和 客观时间 有偏差  

而 柳比歇夫 在全神贯注下，也能感应到客观时间的长度，并且可以精确到分钟  
他有个笔记本（纸质的），用来记录每项 Activity 所花费的时间  
像是管理资金那样，管理 时间  
所以最早我使用一种 记账软件 来做的记录

其实人活到到一定阶段后，就会深刻认识到 **时间** 才是最宝贵的资源，你可以用 时间 去换 钱以及大多数东西，而反过来却不行  
我想这也是张爱玲说 “青春太美好，怎么过都是浪费” 的原因（之一）吧  

##日历
最早用 Google Calendar，只是校招的时候记录各个公司的面试时间，后来看到这本书，一下恍然大悟  
之后傻逼一样的记录了两年，但当时仅仅是记录，从来没回顾过，更别说搞个月总结，年度展望神马的  

然后又看到 [把时间留给最重要的事](http://book.douban.com/subject/2979575/)，这时我突然发现，以前记录的数据派上用场了  
并且此书给我最大的启发就是对日历的应用  
之前我所记录的都是一个颜色，估计这也是我懒得去看的一个原因  
而书中把时间花销分为几个，并且用不同的颜色代表  
我自己的分类：

- 碎片 - 蓝  
- 人际 - 红
- 健康 - 黄
- 兴趣 - 青
- 事业 - 灰

![](http://cl.ly/image/1u3q29200w23/time-harker-3.png)

这样一周下来，扫一眼大致就知道时间的花销情况  

另外为什么别的 APP 不行呢，因为这是项马拉松工程，目前移动互联网的 APP 的生命周期远远短于你记录的寿命  
就说柳比歇夫坚持56年的 "时间统计法"， 别说应用了，能存在那么长时间的公司都非常牛了    

##十万小时天才理论
记录还一个好处，看上面的标题应该已经猜到了  
只要分类准确，把所有相同的一加，结果就出来了

比如编程方面，我投入多少小时，只要运行下这个项目就出来了

当然不是说，结果是 10W，就是天才了  
刻意的训练，时时处在挑战区还是蛮困难的  

不过虽不说成为天才，能看到自己在一项上持续的进步，也是很开心的

##理论指导
 ![img](http://cl.ly/image/2d3l0U0M0r1W/s4102399.jpg) ![image](http://cl.ly/image/3A1h2Q3P2T1N/s4595192.jpg)![image](http://cl.ly/image/453U3Z2O2K3a/s6225672.jpg)![image](http://cl.ly/image/3F2O3D1c1w46/s27133167.jpg)  

##难处
最大的困难是数据的积累，人都是有惰性的，想想各种理财软件吧，那种都短信自动了，我也只用了三个月就扔了  
并且这种事情不是一躇而就，需要长时间的积累和耐心

另外，看多少时间管理作用可能都不大
知行合一，只有用出来了，才是真正懂了  
所以，最好的 GTD，是适合自己的  

没有满意的就自己写一个，不然学编程是干嘛的

转自：[最好的 GTD](https://github.com/Artwalk/Time-Hacker)

---
2014-04-29 22:54:38

add iOS & OS X iCal analytics

Last year I have my rMBP, so Google Cal is not importent as before, especially after I import all cav from gCal to iCal.  

好吧，不装了，Σ( ￣д￣；)  我知道你们也不想看英文  
上次脑抽了用E文，现在我都得看一会儿写的是神马，那时我还没买 rMBP 呢  

刚刚突然想到，也不知道离 10W 还有多少，
虽然到了 10W 也不代表就是天才了，但是忍不住好奇心啊

虽然 MAC 买半年了，但 iOS 开发基本没怎么看，边码边查，居然弄出来了，好开心 ^_^  
测试大概如图：
![](http://cl.ly/image/1e1N1P0k1a1l/time-harker-1.png)

但是偶还木有开发者账号，模拟器上的好像只能同步一个月，肿么会酱紫 \*´∀\`)´∀\`)\*´∀\`)\*´∀\`)  

然后记得看文档时，`EKEventStore` OS X 也可以用，试了下果然可以  
图形界面先不搞了，在 xCode 里面 `NSLog` 看下结果就行了

---

I read many books about how to make full use of time.  

In the process, little by little, I realised that **TIME** are really your *friends* rather than enemies.  

You playing with it, working with it, living with it.  

As a person, You can using past experiences as a base for further improvement.  
So, something like a  *time tracker* would be needed.

In the past two years, I found a lot of softwares such as *idoit Any.do Catch*, which help me a lot.
  
But there was a problem, *time tracker* is something I need to use at least several decades(considering my health). If I use an app, how on earth do I know this app's lifecycle(Catch had already been ceased, all the data I recorded was gone).

The only thing I can see is *Google Calendar*. although they closed *Google's reader*, *Google Calendar* is the best *time tracker* I have ever seen.

But, it's just a tracker, not a hacker.

Here are some ways I'm thinking about:

1. Insert [Pomodoro](http://www.amazon.com/The-Pomodoro-Technique-Francesco-Cirillo/dp/1445219948/ref=pd_sim_b_3) into *Google Calendar*  
1. Analyse all the Event, and generate a chart  