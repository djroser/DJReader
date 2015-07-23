//
//  PCDataViewController.h
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PCPageView.h"
#import "AppDelegate.h"
@interface PCDataViewController : UIViewController

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSDictionary *attributes;
@property (strong, nonatomic) PCPageView *pageView;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPage;

@property (nonatomic) AppDelegate *myDelegate;

@end
