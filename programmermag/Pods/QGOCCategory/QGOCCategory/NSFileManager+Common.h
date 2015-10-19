//
//  NSFileManager+Common.h
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/5.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Common)

/**
 *  在相应目录下创建一个文件夹。
 *  @param  folder:文件夹名。
 *  @param  path:文件夹所在路径。
 *  return  成功返回YES，失败返回NO。若已存在直接返回YES。
 */
+ (BOOL)qgocc_createFolder:(NSString *)folder atPath:(NSString *)path;

/**
 *  保存文件到相应路径下。
 *  @param  data:要保存的数据。
 *  @param  name:要保存的文件名，如a.txt等。
 *  @param  path:文件保存的路径目录。
 *  return  成功返回YES，失败返回NO。
 */
+ (BOOL)qgocc_saveData:(NSData *)data withName:(NSString *)name atPath:(NSString *)path;

/**
 *  查找并返回文件。
 *  @param  fileName:要查找的文件名。
 *  @param  path:文件所在的目录。
 *  return  成功返回文件，失败返回nil。
 */
+ (NSData *)qgocc_findFile:(NSString *)fileName atPath:(NSString *)path;

/**
 *  删除文件。
 *  @param  fileName:要删除的文件名。
 *  @param  path:文件所在的目录。
 *  return  成功返回YES，失败返回NO。
 */
+ (BOOL)qgocc_deleteFile:(NSString *)fileName atPath:(NSString *)path;

@end
