/**
 KCObjcBuild Created by cooci on 2022/11/7.
 
 KC 重磅提示 调试工程很重要 源码直观就是爽
 ⚠️编译调试不能过: 请你检查以下几小点⚠️
 ①: 编译 targets 选择: KCObjcBuild
 ②: enable hardened runtime -> NO
 ③: build phase -> denpendenice -> objc
 ④: team 选择 None
 ⑤: 进入不到源码 微信联系
 iOS进阶内容重磅分享 微信认准: KC_Cooci 麻烦来一个 👍
 */

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface LGPerson : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *hooby;

@property (nonatomic, weak) NSString *dress;

@property (nonatomic, weak) LGPerson *son;

@property (nonatomic, assign) int age;

@property (nonatomic, assign) double height;

@end

@implementation LGPerson

+(void)load{
    NSLog(@"load--");
}

-(void)test1{
    NSLog(@"test1--");
}
@end

LGPerson *globalPerson = nil;

void test1()
{
    NSObject* son = [[LGPerson alloc]init];
    [globalPerson setSon:son];
    NSLog(@"globalPerson.son-:%p",globalPerson.son);
}

@interface Sark : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation Sark

- (void)speak {
    NSLog(@"my name's %@", self.name);
}

@end

void test2()
{
    Class obj_class = [NSObject class];
    Class Sark_class = [Sark class];
    
    id SarkMetaClass = objc_getMetaClass("Sark");

    BOOL res1 = [(id)obj_class isKindOfClass:obj_class];
    BOOL res2 = [(id)obj_class isMemberOfClass:obj_class];
    BOOL res3 = [(id)Sark_class isKindOfClass:Sark_class];
    BOOL res4 = [(id)Sark_class isMemberOfClass:Sark_class];
    
    BOOL res5 = [(id)Sark_class isMemberOfClass:[Sark_class class]];

    BOOL res6 = [(id)Sark_class isMemberOfClass:SarkMetaClass];

    id Sark_class_class = [Sark_class class];
    BOOL res7 = SarkMetaClass == Sark_class_class;
    
    BOOL res8 = [[[Sark alloc]init] isMemberOfClass:Sark_class];

    
    NSLog(@"%d %d %d %d %d %d %d %d", res1, res2, res3, res4, res5, res6, res7, res8);
}

@interface NSObject (Sark)
+ (void)foo;
@end
@implementation NSObject (Sark)
- (void)foo {
    NSLog(@"IMP: -[NSObject (Sark) foo]");
}
@end

void test3()
{
    // 测试代码
    [NSObject foo];
    [[NSObject new] foo];
}

void test4()
{
    id cls = [Sark class];
    void *obj = &cls;
    [(__bridge id)obj test1];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        globalPerson = [LGPerson alloc];
        globalPerson.name = @"woshishui";
        globalPerson.hooby = @"chifan";
        globalPerson.dress = @"shuiyi";
        test1();
        globalPerson.age = 0x44;
        globalPerson.height = 0x77;
        [globalPerson test1];
        [globalPerson.son test1];
        NSLog(@"KCObjcBuild:%p",globalPerson);
        
        
        test2();
        test3();
      //  test4();
    }
    return 0;
}
