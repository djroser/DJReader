//
//  AppDelegate.h
//  DJBookReader
//
//  Created by user on 15/7/20.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger itemTagChange;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) NSInteger itemTagChange;

@end

