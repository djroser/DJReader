//
//  PCReaderViewController.h
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface PCReaderViewController : UIViewController<UIPageViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger bookNum;
@property (nonatomic, weak) UIBarButtonItem *nightItem;
@property (nonatomic) AppDelegate *myDelegate;
- (void)loadText:(NSString *)text;

@end

@protocol PCFontAdjustViewDelegate <NSObject>

- (void)adjustRangeArrayForText;

@end

@interface PCFontAdjustView : UIView

@property (nonatomic, weak) id<PCFontAdjustViewDelegate>delegate;

@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;

@end



