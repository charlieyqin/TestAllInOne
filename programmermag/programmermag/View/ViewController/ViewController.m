//
//  ViewController.m
//  programmermag
//
//  Created by 张如泉 on 15/10/19.
//  Copyright © 2015年 csdn. All rights reserved.
//

#import "ViewController.h"
#import "UALogger.h"
#import "PMDBManager.h"
#import "QGOCCategory.h"

#import "PMAPIManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[[PMAPIManager sharedManager] fetchBookList] subscribeNext:^(id x) {
        UALog(@"%@",x);
    } error:^(NSError *error) {
        UALog(@"%@",error);
    }];
    
    NSArray * allbook = [[PMDBManager getInstance] fetchAllBooks];
    UALog(@"全部书为%@",allbook);
    
    return;
    NSArray * mybook = [[PMDBManager getInstance] fetchMylBooks];
    UALog(@"我的书为%@",allbook);
   
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    documentsDirectoryPath = [documentsDirectoryPath stringByAppendingString:@"/issues100"];
    NSFileManager* manager = [NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:documentsDirectoryPath] objectEnumerator];
    NSString* fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
//        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//        
//        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
        UALog(@"杂志目录为:%@",fileName);
        
    }
    

    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end