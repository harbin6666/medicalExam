//
//  AppDelegate.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "AppDelegate.h"

//#import "RCIM.h"

#import <AFNetworking/AFNetworking.h>

#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <RennSDK/RennSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f]}];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    
//注册
//    [RCIM initWithAppKey:@"pwe86ga5er666" deviceToken:nil];
    
//获取token
//    NSDictionary *dict = @{@"userId": @123456, @"name": @"aimy", @"portraitUri": @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png"};
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager.requestSerializer setValue:@"pwe86ga5er666" forHTTPHeaderField:@"appKey"];
//    [manager.requestSerializer setValue:@"y3hsSd5F7Pm" forHTTPHeaderField:@"appSecret"];

//    WEAK_SELF;
//    AFHTTPRequestOperation *operation = [manager POST:@"https://api.cn.rong.io/user/getToken.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        STRONG_SELF;
//        [RCIMClient connect:responseObject[@"token"] delegate:self];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//
//    [operation start];
    
    
//使用token连接
//    [RCIM connectWithToken:@"mrDlYu9f8VpSuRLBn3s43jE1Wl4wjK89+puRBExEr0u0BchCuWSQNVdik4ShR+R0ZGq3pHHcwIutZoJ1GTEIcQ==" completion:^(NSString *userId) {
//        
//    } error:^(RCConnectErrorCode status) {
//        
//    }];
    
    //    {
    //        News *news = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    
    //        news.title = @"今日头条";
    //        news.date = [NSDate date];
    //        news.count = @20;
    //    }
    //
    //    {
    //        NSError *error = nil;
    //        BOOL isSave =   [self.managedObjectContext save:&error];
    //        if (!isSave) {
    //            NSLog(@"error:%@,%@",error,[error userInfo]);
    //        }
    //        else{
    //            NSLog(@"保存成功");
    //        }
    //    }
    
    //    {
    //        //创建取回数据请求
    //        NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //        //设置要检索哪种类型的实体对象
    //        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item"inManagedObjectContext:self.managedObjectContext];
    //        //设置请求实体
    //        [request setEntity:entity];
    //        //指定对结果的排序方式
    //        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"ascending:NO];
    //        NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    //        [request setSortDescriptors:sortDescriptions];
    //        NSError *error = nil;
    //        //执行获取数据请求，返回数组
    //        NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    //        if (mutableFetchResult == nil) {
    //            NSLog(@"Error: %@,%@",error,[error userInfo]);
    //        }
    //
    //        NSLog(@"%@",mutableFetchResult);
    //    }
    //
    //    NSLog(@"\n");
    //
    //    {
    //        //创建取回数据请求
    //        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    //        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    //        NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    //        [request setSortDescriptors:sortDescriptions];
    //
    //        NSError *error = nil;
    //        //执行获取数据请求，返回数组
    //        NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    //        if (mutableFetchResult == nil) {
    //            NSLog(@"Error: %@,%@",error,[error userInfo]);
    //        }
    //
    //        NSLog(@"%@",mutableFetchResult);
    //    }
    
    return YES;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.yihaodian.onethestore.TestCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Beck" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Beck.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
