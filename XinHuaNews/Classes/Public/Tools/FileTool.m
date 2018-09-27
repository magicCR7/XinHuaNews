//
//  FileTool.m
//  EasyNews
//
//  Created by Mc on 2018/7/16.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "FileTool.h"

@implementation FileTool

// 自己去计算SDWebImage做的缓存
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        //抛异常
        //name：异常名称 reason：报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹的路径，并且路径要存在" userInfo:nil];
        [excp raise];
    }
    
    //异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件夹下所有的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        //计算完成 回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            //计算完成回调
            
            if (completion) {
                completion(totalSize);
            }
            
        });
        
    });
    
}

+ (void)removeDirectoryPath:(NSString *)DirectoryPath{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:DirectoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        //抛异常
        //name：异常名称 reason：报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹的路径，并且路径要存在" userInfo:nil];
        [excp raise];
    }
    
    //获取cache文件夹下所有文件 不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:DirectoryPath error:nil];
    for (NSString *subPath in subPaths){
        //拼接完成全路径
        NSString *filePath = [DirectoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
    
}

@end
