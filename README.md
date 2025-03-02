# KCObjc_debug

可编译苹果官方源码 `objc`！可编译源码，LLDB调试，方便大家探索学习！
![](资源图片/mainImage.png)

-------
> 🆕 2022年11月21日更新 `libmalloc-409.40.6可编译`
> 
> 环境: `macOS 13.0 Xcode 14.1`
-------
> 🆕 2022年11月7日更新 `objc4-866.9`
> 
> 环境: `macOS 13.0 Xcode 14.1`

-------
> 🆕 2022年2月25 更新 `objc4-838` 可编译源码 
> 
> 环境: `macOS 12.1 Xcode 13.2`

![](资源图片/objc4-838.png)
-------
> ⚠️ 2021年4月26号更新 编译调试成功 `libmalloc-317.40.8` 方便进行 `objc` 下层申请开辟内存情况调试  
>
> ⚠️ 2021年1月5号更新: 在苹果系统 `bigSur` (`macOS 11`) `xcode 12.2` 源码编译报错的问题解决! 大家及时更新源码 **`objc4-818.2`** 

[![Build Status](https://travis-ci.org/LGCooci/objc4_debug.svg?branch=master)](https://travis-ci.org/LGCooci/objc4_debug)
[![Xcode 10.0+](https://img.shields.io/badge/Xcode-10.0%2B-blue.svg?colorA=3caefc&colorB=24292e)](https://developer.apple.com/xcode/)
[![VSTS Build](https://alchemistxxd.visualstudio.com/_apis/public/build/definitions/e0656143-5484-4af8-8aa3-01f9baba5da1/1/badge)](https://alchemistxxd.visualstudio.com/Apple%20Open%20Source/_git/objc4)
![support](https://img.shields.io/badge/support-macOS%20%7C%20iOS-orange.svg) 
![GitHub top language](https://img.shields.io/github/languages/top/0xxd0/objc4.svg?colorB=6866fb) 
[![Join the chat at https://gitter.im/0xxd0/objc4](https://badges.gitter.im/0xxd0/objc4.svg)](https://gitter.im/0xxd0/objc4?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


![](资源图片/objc4-818.2.png)


> 很多小伙伴在探索底层的时候经常很苦恼，只能靠猜测！稍微灵活一点的小伙伴会通过 `Apple` 提供的源码来辅助看一下，但是很显然这不太直观！如果能够直接编译调试，像我们自己的代码直接 LLDB 调试，流程跟踪。那简直不要太爽，于是我编译了现在最新的`objc4-源码` 

### 准备工作

如果想先来体验一把的小伙伴可以直接 [GitHub 源码](https://github.com/LGCooci/objc_debug/tree/master) 下载！

如果你也想亲自体验一把，请你准备条件：

* mac OS 10.14
* Xcode 10.1
* objc4-756.2

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab6bf541f33a7?w=1224&h=450&f=png&s=74063)

以上资料都可以在 [Apple source](https://opensource.apple.com) 获取到。

### 开始配置

#### i386 架构问题

首先你下载的`iOS_objc4-756.2` 直接编译会报错如下：

> Showing Recent Messages
The i386 architecture is deprecated. You should update your ARCHS build setting to remove the i386 architecture.

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab70482537e3d?w=2080&h=1300&f=png&s=1205964)

> 解决： 将 `objc` 和 `objc-trampolines` 中的 `Build Settings` 选项 `Architectures` 中的值切换为 `Standard Architectures(64-bit Intel)`

#### 文件查漏补缺

> 'sys/reason.h' file not found

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab76947e1eee8?w=2434&h=982&f=png&s=1035826)

这个资料我已经给大家找好了：
* 大家可以通过 [GitHub 源码](https://github.com/LGCooci/objc_debug/tree/master) 下载，路径在 `objc-756.2编译资料/xnu-4903.241.1/bsd/sys/reason.h`
* 或者大家可以通过 [Apple source](https://opensource.apple.com) 在 `xnu-4903.241.1/bsd/sys/reason.h` 路径自行下载
* 还可以通过谷歌中输入`reason.h site:opensource.apple.com` 定向检索

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab793355fc0fe?w=1104&h=508&f=png&s=123244)

把找到的文件加入到工程里面。例如：
* 我在根目录创建了一个 `KCCommon` 文件
* 创建 `sys` 文件
* 把 `reason.h` 文件加入进去

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab7ec1bd04c18?w=1238&h=220&f=png&s=39160)

**目前还不行，一定给我们的工程设置文件检索路径**

* 选择 `target` -> `objc` -> `Build Settings` 
* 在工程的 `Header Serach Paths` 中添加搜索路径 `$(SRCROOT)/KCCommon`


![](https://user-gold-cdn.xitu.io/2019/10/8/16dab836d6f6d070?w=1850&h=590&f=png&s=252988)

> `'mach-o/dyld_priv.h' file not found`
>
> `'os/lock_private.h' file not found`
>
> `'os/base_private.h' file not found`
>
> `'pthread/tsd_private.h' file not found`
>
> `'System/machine/cpu_capabilities.h' file not found`
>
> `'os/tsd.h' file not found`
>
> `'pthread/spinlock_private.h' file not found`
>
> `'System/pthread_machdep.h' file not found`
>
> `'CrashReporterClient.h' file not found`
>
> `'objc-shared-cache.h' file not found`
>
> `'_simple.h' file not found`
>
> `'Block_private.h' file not found`

**上面的报错情况处理方式都是和 `'sys/reason.h' file not found` 一样的解决**

文件补漏情况如下图：

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab8ec2630593d?w=1246&h=350&f=png&s=80779)

#### CrashReporterClient异常

我们如果直接导入 [Apple source](https://opensource.apple.com) 下载的 `CrashReporterClient` 还是会报错：

> 'CrashReporterClient.h' file not found

解决：
* 需要在 `Build Settings` -> `Preprocessor Macros` 中加入：`LIBC_NO_LIBCRASHREPORTERCLIENT`
* 或者下载我给大家的文件`CrashReporterClient`,这里面我们直接更改了里面的宏信息 `#define LIBC_NO_LIBCRASHREPORTERCLIENT`

#### dyld_priv 文件修改

[GitHub 源码](https://github.com/LGCooci/objc_debug/tree/master) 这是修改过的！下面板书我修改了什么

> 报错：Use of undeclared identifier ‘DYLD_MACOSX_VERSION_10_13

在 `dyld_priv.h` 文件顶部加入一下宏：

```objc
#define DYLD_MACOSX_VERSION_10_11 0x000A0B00
#define DYLD_MACOSX_VERSION_10_12 0x000A0C00
#define DYLD_MACOSX_VERSION_10_13 0x000A0D00
#define DYLD_MACOSX_VERSION_10_14 0x000A0E00
```

#### libobjc.order 路径问题

> Can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order

* 选择 `target` -> `objc` -> `Build Settings` 
* 在工程的 `Order File` 中添加搜索路径 `$(SRCROOT)/libobjc.order`

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab99438d1b577?w=2018&h=658&f=png&s=196711)

#### lCrashReporterClient 编译不到

> Library not found for -lCrashReporterClient

* 选择 `target` -> `objc` -> `Build Settings` 
* 在 `Other Linker Flags` 中删除 `-lCrashReporterClient` ( `Debug` 和 `Release` 都删了)

![](https://user-gold-cdn.xitu.io/2019/10/8/16dab9d3b5f80494?w=2030&h=1034&f=png&s=353867)

#### _objc_opt_class 无法编译

> Undefined symbol: _objc_opt_class

这个问题是因为要适配新系统：MacOS 10.15, 因为现在笔者写这一篇文章的时候，还没有正式版本推送！这里我们向下兼容 `MacOS 10.14`

![](https://user-gold-cdn.xitu.io/2019/10/8/16daba101baf48d7?w=1396&h=420&f=png&s=150495)

#### Xcode 脚本编译问题

> /xcodebuild:1:1: SDK "macosx.internal" cannot be located.
>
> /xcrun:1:1: sh -c '/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -sdk macosx.internal -find clang++ 2> /dev/null' failed with exit code 16384: (null) (errno=No such file or directory)
>
> /xcrun:1:1: unable to find utility "clang++", not a developer tool or in PATH

* 选择 `target` -> `objc` -> `Build Phases` -> `Run Script(markgc)` 
* 把脚本文本 `macosx.internal` 改成 `macosx`

![](https://user-gold-cdn.xitu.io/2019/10/8/16daba2984bb3f4b?w=2026&h=958&f=png&s=184542)


#### ObjectiveC.apinotes 异常

> no such public header file: '/tmp/objc.dst/usr/include/objc/ObjectiveC.apinotes'


* 选择 `target` -> `objc` -> `Build Settings` 
* `Text-Based InstallAPI Verification Model` 中添加搜索路径 `Errors Only`

![](https://user-gold-cdn.xitu.io/2019/10/8/16daba631013f6cf?w=1912&h=794&f=png&s=356492)

* `Other Text-Based InstallAPI Flags` 清空所有内容

![](https://user-gold-cdn.xitu.io/2019/10/8/16daba80f1e4b516?w=1908&h=790&f=png&s=194094)

#### 编译成功

接下来你可以编译 - `Build Succeeded` - 恭喜你！💐

可能到这里你已经老血吐了一地了！的确配置过程还是相对来说有点恶心，尤其是文件的查漏补缺，但是我们享受编译成功的喜悦吧！

### objc 编译调试

* 新建一个 `Target` : LGTest

![](https://user-gold-cdn.xitu.io/2019/10/8/16dabbc0c98ecf8d?w=1428&h=1042&f=png&s=310295)

* 绑定二进制依赖关系

![](https://user-gold-cdn.xitu.io/2019/10/8/16dabbdc087116ed?w=1866&h=800&f=png&s=75281)

* 运行代码进入源码，大家可以自由编译调试咯！

![](https://user-gold-cdn.xitu.io/2019/10/8/16dabbb3da06cc9d?w=2806&h=660&f=png&s=737329)

### 总结

iOS 现在更多的会偏向底层开发研究，可调式编译的 `objc4 源码`能够帮助更快速学习和更容易理解！博客持续更新中，谢谢大家的关注点赞！Thanks♪(･ω･)ﾉ
更多博客请关注：[Cooci 掘金博客地址](https://juejin.im/user/5c3f3c415188252b7d0ea40c/posts)



# 运行记录


1. 2025.01.10  x86_64 macos13.5 可以正常运行 ‘objc4-866.9’


# 学习

## 1.对象的初始化，并设置isa

```


* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 17.1
  * frame #0: 0x000000010065bf1d libobjc.A.dylib`objc_object::initIsa(this=0x0000000100008288, cls=0x00000001006e70f0, nonpointer=false, hasCxxDtor=false) at objc-object.h:364:5
    frame #1: 0x000000010068097f libobjc.A.dylib`objc_object::initClassIsa(this=0x0000000100008288, cls=0x00000001006e70f0) at objc-object.h:298:9
    frame #2: 0x000000010066b0fd libobjc.A.dylib`realizeClassWithoutSwift(cls=0x0000000100008288, previously=0x0000000000000000) at objc-runtime-new.mm:2705:10
    frame #3: 0x00000001006991ee libobjc.A.dylib`realizeClassMaybeSwiftMaybeRelock(cls=0x0000000100008288, lock=0x00000001006ea0c0, leaveLocked=true) at objc-runtime-new.mm:2882:9
    frame #4: 0x0000000100674802 libobjc.A.dylib`realizeClassMaybeSwiftAndLeaveLocked(cls=0x0000000100008288, lock=0x00000001006ea0c0) at objc-runtime-new.mm:2905:12
    frame #5: 0x000000010067b3cb libobjc.A.dylib`realizeAndInitializeIfNeeded_locked(inst=0x00000001000082b0, cls=0x0000000100008288, initialize=true) at objc-runtime-new.mm:6755:15
    frame #6: 0x000000010067aecc libobjc.A.dylib`lookUpImpOrForward(inst=0x00000001000082b0, sel="alloc", cls=0x0000000100008288, behavior=11) at objc-runtime-new.mm:6870:11
    frame #7: 0x00000001006b681b libobjc.A.dylib`_objc_msgSend_uncached at objc-msg-x86_64.s:1153
    frame #8: 0x00000001006cb404 libobjc.A.dylib`objc_alloc [inlined] callAlloc(cls=0x00000001000082b0, checkNil=true, allocWithZone=false) at NSObject.mm:2011:12
    frame #9: 0x00000001006cb35c libobjc.A.dylib`objc_alloc(cls=0x00000001000082b0) at NSObject.mm:2027:12
    frame #10: 0x0000000100003c29 KCObjcBuild`main(argc=1, argv=0x00007ff7bfeff450) at main.m:20:23 [opt]
    frame #11: 0x00007ff80e80e41f dyld`start + 1903
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 17.1
  * frame #0: 0x000000010065bf1d libobjc.A.dylib`objc_object::initIsa(this=0x0000000100008288, cls=0x00000001006e70f0, nonpointer=false, hasCxxDtor=false) at objc-object.h:364:5
    frame #1: 0x000000010068097f libobjc.A.dylib`objc_object::initClassIsa(this=0x0000000100008288, cls=0x00000001006e70f0) at objc-object.h:298:9
    frame #2: 0x000000010066b0fd libobjc.A.dylib`realizeClassWithoutSwift(cls=0x0000000100008288, previously=0x0000000000000000) at objc-runtime-new.mm:2705:10
    frame #3: 0x00000001006991ee libobjc.A.dylib`realizeClassMaybeSwiftMaybeRelock(cls=0x0000000100008288, lock=0x00000001006ea0c0, leaveLocked=true) at objc-runtime-new.mm:2882:9
    frame #4: 0x0000000100674802 libobjc.A.dylib`realizeClassMaybeSwiftAndLeaveLocked(cls=0x0000000100008288, lock=0x00000001006ea0c0) at objc-runtime-new.mm:2905:12
    frame #5: 0x000000010067b3cb libobjc.A.dylib`realizeAndInitializeIfNeeded_locked(inst=0x00000001000082b0, cls=0x0000000100008288, initialize=true) at objc-runtime-new.mm:6755:15
    frame #6: 0x000000010067aecc libobjc.A.dylib`lookUpImpOrForward(inst=0x00000001000082b0, sel="alloc", cls=0x0000000100008288, behavior=11) at objc-runtime-new.mm:6870:11
    frame #7: 0x00000001006b681b libobjc.A.dylib`_objc_msgSend_uncached at objc-msg-x86_64.s:1153
    frame #8: 0x00000001006cb404 libobjc.A.dylib`objc_alloc [inlined] callAlloc(cls=0x00000001000082b0, checkNil=true, allocWithZone=false) at NSObject.mm:2011:12
    frame #9: 0x00000001006cb35c libobjc.A.dylib`objc_alloc(cls=0x00000001000082b0) at NSObject.mm:2027:12
    frame #10: 0x0000000100003c29 KCObjcBuild`main(argc=1, argv=0x00007ff7bfeff450) at main.m:20:23 [opt]
    frame #11: 0x00007ff80e80e41f dyld`start + 1903


```


一个初始化后的对象内存空间是：

isa + 对象属性值组成的


1.属性赋值前

```
(lldb) p/x p
(LGPerson *) 0x0000600000c04120
(lldb) x/100 0x0000600000c04120
0x600000c04120: 0x000082b5 0x011d8001 0x00000000 0x00000000
0x600000c04130: 0x00000000 0x00000000 0x00000000 0x00000000
0x600000c04140: 0x00000000 0x00000000 0x00000000 0x00000000

```
2.属性赋值后


```

        LGPerson *p = [LGPerson alloc];
        p.name = @"lsl";
        p.hooby = @"chifan";
        p.age = 20;
        p.height = 200;


```

```

(lldb) x/100 0x0000600000c04120
0x600000c04120: 0x000082b5 0x011d8001 0x00000014 0x00000000
0x600000c04130: 0x00004058 0x00000001 0x00004078 0x00000001
0x600000c04140: 0x00000000 0x40690000 0x00000000 0x00000000

```
