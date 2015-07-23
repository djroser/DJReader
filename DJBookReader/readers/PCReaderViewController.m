//
//  PCReaderViewController.m
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#define ReadKey [NSString stringWithFormat:@"book%ld",self.bookNum]

#import "PCReaderViewController.h"
#import "PCModelViewController.h"
#import "PCDataViewController.h"
#import "PCGlobalModel.h"
#import "ReadMark.h"


@interface PCReaderViewController ()<UICollectionViewDelegate, PCFontAdjustViewDelegate>

@property (strong, nonatomic) PCModelViewController *modelController;
@property (strong, nonatomic) PCGlobalModel *globalModel;
@property (strong, nonatomic) PCFontAdjustView *fontAdjustView;
@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UIButton *backgroundView;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) BOOL isShowMenu;

@property (strong, nonatomic) NSArray *toolbarConstraintArray;

@end

@implementation PCReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.delegate = self;
    
    PCDataViewController *startingViewController = [self.modelController viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageController.dataSource = self.modelController;
    self.modelController.readerController = self;
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageController.view.frame = pageViewRect;
    
    [self.pageController didMoveToParentViewController:self];
    
    
    
    [self.view addSubview:self.menuButton];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_menuButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_menuButton)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0]];
    
    [self setupBackgroundView];
    [self setupToolbar];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.myDelegate = [[UIApplication sharedApplication] delegate];
    
    if (self.myDelegate.itemTagChange == 0) {
        [self.nightItem setTitle:@"夜间"];
    } else {
        [self.nightItem setTitle:@"白天"];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ReadMark *readMark = [[ReadMark alloc]init];
    
    readMark.lastRead = [PCGlobalModel shareModel].currentPage;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:readMark];
    
    [defaults setObject:data forKey:ReadKey];
    [defaults synchronize];
    
}


- (void)setupBackgroundView
{
    self.backgroundView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addTarget:self action:@selector(backgroundAction) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundView.hidden = YES;
    
    [self.view addSubview:self.backgroundView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_backgroundView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backgroundView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backgroundView)]];
}

- (void)setupToolbar
{
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"夜间" style:UIBarButtonItemStylePlain target:self action:@selector(switchNightAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"上次位置" style:UIBarButtonItemStylePlain target:self action:@selector(changeReadAction)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"字体" style:UIBarButtonItemStylePlain target:self action:@selector(adjustFontAction)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(downloadAction)];
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithTitle:@"书签" style:UIBarButtonItemStylePlain target:self action:@selector(catalogAction)];
    UIBarButtonItem *fixibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.nightItem = item1;
    
    [self.toolbar setItems:@[item1,fixibleItem,item2,fixibleItem,item3,fixibleItem,item4,fixibleItem,item5]];
    
    [self.view addSubview:self.fontAdjustView];
    
    [self.view addSubview:self.toolbar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_toolbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)]];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]-(-48)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_fontAdjustView(44)]-48-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fontAdjustView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fontAdjustView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fontAdjustView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:98]];
}

- (void)showToolbar
{
    [self.view removeConstraints:self.toolbarConstraintArray];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideToolbar
{
    [self.view removeConstraints:self.toolbarConstraintArray];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]-(-48)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)loadText:(NSString *)text
{
    [self.globalModel loadText:text completion:^{
        
        self.modelController.text = self.globalModel.text;
        self.modelController.attributes = self.globalModel.attributes;
        self.modelController.pageData = self.globalModel.rangeArray;

    }];
}

- (void)pageControllerSetIndex:(NSInteger)index
{
    [self.pageController setViewControllers:@[[self.modelController viewControllerAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)memuAction
{
    self.isShowMenu = !self.isShowMenu;
    
    [self.navigationController setNavigationBarHidden:!self.isShowMenu animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.backgroundView.hidden = !self.isShowMenu;
    if (self.isShowMenu) {
        [self showToolbar];
    } else {
        [self hideToolbar];
    }
}

- (void)backgroundAction
{
    self.isShowMenu = NO;
    
    [self.navigationController setNavigationBarHidden:!self.isShowMenu animated:YES];
    self.backgroundView.hidden = !self.isShowMenu;
    self.fontAdjustView.alpha = 0;
    if (self.isShowMenu) {
        [self showToolbar];
    } else {
        [self hideToolbar];
    }
}

- (PCModelViewController *)modelController {
    
    if (!_modelController) {
        _modelController = [[PCModelViewController alloc] init];
    }
    return _modelController;
}

- (BOOL)prefersStatusBarHidden
{
    return !self.isShowMenu;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

//#pragma mark - UICollectionViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger page = scrollView.contentOffset.y / scrollView.frame.size.height;
//    [PCGlobalModel shareModel].currentPage = page;
//    [PCGlobalModel shareModel].currentRange = NSRangeFromString([PCGlobalModel shareModel].rangeArray[page]);
//    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatePageNotification object:nil];
//}

#pragma mark - PCFontAdjustViewDelegate

- (void)adjustRangeArrayForText
{
    [[PCGlobalModel shareModel] updateFontCompletion:^{
        
        self.modelController.text = self.globalModel.text;
        self.modelController.attributes = self.globalModel.attributes;
        self.modelController.pageData = self.globalModel.rangeArray;
        [self pageControllerSetIndex:[PCGlobalModel shareModel].currentPage];
    }];
}

#pragma mark - toolbar Action

- (void)switchNightAction:(UIBarButtonItem *)item
{
    
    
//    self.isNight = !self.isNight;
    
    if (self.myDelegate.itemTagChange == 0) {
        [item setTitle:@"白天"];
    } else {
        [item setTitle:@"夜间"];
    }
    item.tag = 1;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBackgroundColor" object:item userInfo:nil];
    
    
}

- (void)changeReadAction
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:ReadKey];
    
    ReadMark *readMark = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [PCGlobalModel shareModel].currentPage = readMark.lastRead;
    [self pageControllerSetIndex:[PCGlobalModel shareModel].currentPage];
}

- (void)adjustFontAction
{
    if (self.fontAdjustView.alpha == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.fontAdjustView.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.fontAdjustView.alpha = 0;
        }];
    }
}

- (void)downloadAction
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:ReadKey];
    ReadMark *readMark = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (readMark.mark1 == 0) {
        readMark.lastRead = [PCGlobalModel shareModel].currentPage;
        readMark.mark1 = [PCGlobalModel shareModel].currentPage;
        
        
    } else if (readMark.mark2 == 0) {
        
        readMark.mark2 = [PCGlobalModel shareModel].currentPage;
        
    } else if (readMark.mark3 == 0) {
        
        readMark.mark3 = [PCGlobalModel shareModel].currentPage;
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"书签已满，请清空书签后重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }

    
    
    data = [NSKeyedArchiver archivedDataWithRootObject:readMark];
    
    [defaults setObject:data forKey:ReadKey];
    [defaults synchronize];
}

- (void)catalogAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"书签" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空书签" otherButtonTitles:@"书签1", @"书签2",@"书签3",nil];
    
    [actionSheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:ReadKey];
    ReadMark *readMark = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (buttonIndex == 0) {
        readMark.mark1 = 0;
        readMark.mark2 = 0;
        readMark.mark3 = 0;
        
        data = [NSKeyedArchiver archivedDataWithRootObject:readMark];
        [defaults setObject:data forKey:ReadKey];
        [defaults synchronize];
        
    }
    
    if (buttonIndex == 1) {
        
        [PCGlobalModel shareModel].currentPage = readMark.mark1;
        [self pageControllerSetIndex:[PCGlobalModel shareModel].currentPage];
    }
    
    if (buttonIndex == 2) {
        
        [PCGlobalModel shareModel].currentPage = readMark.mark2;
        [self pageControllerSetIndex:[PCGlobalModel shareModel].currentPage];
    }
    
    if (buttonIndex == 3) {
        
        [PCGlobalModel shareModel].currentPage = readMark.mark3;
        [self pageControllerSetIndex:[PCGlobalModel shareModel].currentPage];
    }


}


- (UIButton *)menuButton
{
    if (!_menuButton) {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_menuButton addTarget:self action:@selector(memuAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}


- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}


- (PCGlobalModel *)globalModel
{
    if (!_globalModel) {
        _globalModel = [PCGlobalModel shareModel];
    }
    return _globalModel;
}

- (PCFontAdjustView *)fontAdjustView
{
    if (!_fontAdjustView) {
        _fontAdjustView = [[PCFontAdjustView alloc] init];
        _fontAdjustView.translatesAutoresizingMaskIntoConstraints = NO;
        _fontAdjustView.alpha = 0;
        _fontAdjustView.delegate = self;
    }
    return _fontAdjustView;
}



@end










@implementation PCFontAdjustView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.plusButton];
        [self addSubview:self.minusButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_plusButton, _minusButton);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_plusButton(44)]-10-[_minusButton(44)]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_plusButton(44)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_minusButton(44)]" options:0 metrics:nil views:views]];
    }
    return self;
}

- (void)plusAction
{
    if ([PCGlobalModel shareModel].fontSize >= 30) {
//        self.plusButton.enabled = NO;
    } else {
        self.plusButton.enabled = YES;
        [PCGlobalModel shareModel].fontSize += 2;
        //更新字体
        if ([self.delegate respondsToSelector:@selector(adjustRangeArrayForText)]) {
            [self.delegate adjustRangeArrayForText];
        }
    }
}

- (void)minusAction
{
    if ([PCGlobalModel shareModel].fontSize <= 14) {
//        self.minusButton.enabled = NO;
    } else {
        self.minusButton.enabled = YES;
        [PCGlobalModel shareModel].fontSize -= 2;
        //更新字体
        if ([self.delegate respondsToSelector:@selector(adjustRangeArrayForText)]) {
            [self.delegate adjustRangeArrayForText];
        }
    }
}

- (UIButton *)plusButton
{
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_plusButton setTitle:@"+" forState:UIControlStateNormal];
        _plusButton.backgroundColor = [UIColor redColor];
        [_plusButton addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (UIButton *)minusButton
{
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        _minusButton.backgroundColor = [UIColor redColor];
        [_minusButton addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
}

@end












