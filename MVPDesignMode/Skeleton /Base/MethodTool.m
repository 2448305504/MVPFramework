//
//  MethodTool.m
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/8.
//

#import "MethodTool.h"
// 导入runtime头文件
#import <objc/runtime.h>
@implementation MethodTool

+ (void)printMothListWithObj:(id)obj {

    unsigned int mothCout_f =0;

    Method* mothList_f = class_copyMethodList([obj class], &mothCout_f);

    for (int i = 0; i < mothCout_f; i ++) {

        Method temp_f = mothList_f[i];
//        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);

        const char *name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp_f);
        const char *encoding = method_getTypeEncoding(temp_f);

        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }

    free(mothList_f);
}

@end
