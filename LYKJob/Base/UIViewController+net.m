//
//  UIViewController+net.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "UIViewController+net.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#define TEST

#define TEST_JOB_URL @"http://111.206.11.110:8282/lykJob"
#define CASE_SERVER @"https://cas.leyikao.net/v1/tickets"

#ifdef TEST

#define JOB_URL TEST_JOB_URL

#else

#define JOB_URL PRODUCT_JOB_URL

#endif

@implementation UIViewController (Net)

- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self.view hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    if (message) {
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
    }
    else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (second > 0) {
        [hud hide:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self.view];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

@end

@implementation NSObject (net)

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Cookie"]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    }
    
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    AFHTTPRequestOperation *operation = [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *headers = [[operation response] allHeaderFields];
        [self saveCookie:headers];
        
        NSString *responseObjectString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *responseJsonString = [responseObjectString substringWithRange:NSMakeRange(5, responseObjectString.length - 6)];
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseJsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nresponseObject = %@",url,params,json);
        if (block) {
            block(json, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nerror = %@",url,params,error);
        if (block) {
            block(operation, error);
        }
    }];
    
    [operation start];
}

- (void)getValueWithLYKUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block
{
    NSString *beckUrl = [JOB_URL stringByAppendingString:url];
    [self getValueWithUrl:beckUrl params:params CompleteBlock:block];
}

- (void)saveCookie:(NSDictionary *)headers
{
    NSArray *cookies = [headers[@"Set-Cookie"] componentsSeparatedByString:@";"];
    [cookies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *cookie = obj;
        NSRange range = [cookie rangeOfString:@"JSESSIONID"];
        if (range.location != NSNotFound) {
            NSLog(@"%@",cookie);
            [[NSUserDefaults standardUserDefaults] setValue:cookie forKey:@"Cookie"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            *stop = YES;
        }
    }];
}

- (void)getValueTicketWithParams:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block
{
    NSString *url = CASE_SERVER;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",params[@"user.userEmail"],params[@"user.userPwd"]];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/javascript", @"text/html",@"text/plain",@"text/html;charset=ISO-8859-1", nil];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndex:400];

    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSHTTPURLResponse *response = operation.response;
        if (response.statusCode == 201) {
            NSDictionary *headers = response.allHeaderFields;
            NSLog(@"%@",headers[@"Location"]);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:headers[@"Location"]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
            [request setHTTPMethod:@"POST"];
            NSString *str = [NSString stringWithFormat:@"service=%@/userJ!loginCheck",JOB_URL];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            AFHTTPRequestOperation *operation1 = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSString *responseObjectString = [[NSString alloc] initWithData:operation.responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@",responseObjectString);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/userJ!loginCheck?ticket=%@",JOB_URL,responseObjectString]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
                [request setHTTPMethod:@"POST"];
                
                AFHTTPRequestOperation *operation2 = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSDictionary *headers = [[operation response] allHeaderFields];
                    [self saveCookie:headers];
                    
                    NSString *responseObjectString = [[NSString alloc] initWithData:operation.responseObject encoding:NSUTF8StringEncoding];
                    NSString *responseJsonString = [responseObjectString substringWithRange:NSMakeRange(5, responseObjectString.length - 6)];
                    
                    NSError *errorJson;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseJsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
                    
                    NSLog(@"\n\nurl = %@\n\nparams = %@\n\nresponseObject = %@",url,params,json);
                    if (block) {
                        block(json, errorJson);
                    }
                }];
                
                [operation2 start];
            }];
            
            [operation1 start];
        }
        else {
            if (block) {
                block(operation, error);
            }
        }
    }];
    [operation start];
}

- (void)getBoolValueWithLYKUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",JOB_URL,url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Cookie"]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    }
    
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    AFHTTPRequestOperation *operation = [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *headers = [[operation response] allHeaderFields];
        [self saveCookie:headers];
        
        NSString *responseObjectString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *responseJsonString = [responseObjectString substringWithRange:NSMakeRange(5, responseObjectString.length - 6)];
        
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nresponseObject = %@",urlString,params,responseJsonString);
        if (block) {
            block(responseJsonString, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nerror = %@",urlString,params,error);
        if (block) {
            block(operation, error);
        }
    }];
    
    [operation start];
}

- (NSString *)urlEncodingAllCharacter:(NSString *)string
{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                            (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",                                            kCFStringEncodingUTF8));
    return outputStr;
}

- (void)upload:(UIImage *)image completeBlock:(LYKCompletionBlock)block progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))pblock
{
    NSData *data = nil;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }
    else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/resumeJ!uploadLogo",JOB_URL];
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation *operation = [requestManager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        if (UIImagePNGRepresentation(image)) {
            [dictionary setObject:@"image/png" forKey:@"Content-Type"];
            [dictionary setObject:@"form-data; name=\"file\"; filename=\"file.png\"" forKey:@"Content-Disposition"];
        }
        else {
            [dictionary setObject:@"image/jpeg" forKey:@"Content-Type"];
            [dictionary setObject:@"form-data; name=\"file\"; filename=\"file.jpg\"" forKey:@"Content-Disposition"];
        }
        [dictionary setObject:[NSNumber numberWithInteger:data.length] forKey:@"Content-Length"];
        [formData appendPartWithHeaders:dictionary body:data];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *headers = [[operation response] allHeaderFields];
        [self saveCookie:headers];
        
        NSString *responseObjectString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *responseJsonString = [responseObjectString substringWithRange:NSMakeRange(5, responseObjectString.length - 6)];
        NSError *errorJson;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseJsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
        
        NSLog(@"\n\nurl = %@\n\nresponseObject = %@",urlString,json);
        if (block) {
            block(json, errorJson);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n\nurl = %@\n\nerror = %@",urlString,error);
        if (block) {
            block(operation, error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (pblock) {
            pblock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }
    }];
}

- (UITableViewCell *)getTableViewCell
{
    UITableViewCell *cell = nil;
    if ([self isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)self;
        for (int i = 0; i < 10; i++) {
            view = view.superview;
            if ([view isKindOfClass:[UITableViewCell class]]) {
                cell = (UITableViewCell *)view;
            }
        }
    }
    
    return cell;
}

- (UICollectionViewCell *)getCollectionViewCell
{
    UICollectionViewCell *cell = nil;
    if ([self isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)self;
        for (int i = 0; i < 10; i++) {
            view = view.superview;
            if ([view isKindOfClass:[UICollectionViewCell class]]) {
                cell = (UICollectionViewCell *)view;
            }
        }
    }
    
    return cell;
}

@end

