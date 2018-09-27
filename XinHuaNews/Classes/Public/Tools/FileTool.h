//
//  FileTool.h
//  EasyNews
//
//  Created by Mc on 2018/7/16.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject

//获取文件夹尺寸
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

//删除文件夹所有文件
+ (void)removeDirectoryPath:(NSString *)DirectoryPath;

@end
