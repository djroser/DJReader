//
//  PCDataViewController.m
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//


#import "PCDataViewController.h"
#import "PCGlobalModel.h"
#import "PCReaderViewController.h"


@interface PCDataViewController ()




@end

@implementation PCDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.progressLabel];
    [self.view addSubview:self.timeLabel];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_pageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-1-[_pageView]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_progressLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView, _progressLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_progressLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView, _progressLabel)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeLabel)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_timeLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeLabel)]];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePage) name:kUpdatePageNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeBackgroundColor:) name:@"ChangeBackgroundColor" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pageView setAttributedText:[[NSAttributedString alloc] initWithString:self.dataObject attributes:self.attributes]];
    [self.progressLabel setText:[NSString stringWithFormat:@"%ld/%ld", (long)self.currentPage + 1, (long)self.totalPage]];
    
    self.myDelegate = [[UIApplication sharedApplication] delegate];
    
    if (self.myDelegate.itemTagChange == 1) {
        self.pageView.backgroundColor = [UIColor darkGrayColor];
        self.view.backgroundColor = [UIColor darkGrayColor];

    } else {
        self.pageView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}


- (void)ChangeBackgroundColor:(NSNotification *)notification
{
    UIBarButtonItem *item = [notification object];
    
    if (self.myDelegate.itemTagChange == item.tag) {
        self.pageView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
        self.myDelegate.itemTagChange = 0;
    } else {
        self.pageView.backgroundColor = [UIColor darkGrayColor];
        self.view.backgroundColor = [UIColor darkGrayColor];
        self.myDelegate.itemTagChange = item.tag;
    }
    
}


- (void)updatePage
{
    [self.progressLabel setText:[NSString stringWithFormat:@"%ld/%ld", (long)[PCGlobalModel shareModel].currentPage + 1, (long)self.totalPage]];
}

#pragma mark - lazy loading

- (PCPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[PCPageView alloc] init];
        _pageView.translatesAutoresizingMaskIntoConstraints = NO;
        _pageView.backgroundColor = [UIColor whiteColor];
    }
    return _pageView;
}

- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _progressLabel.font = [UIFont systemFontOfSize:14];
        _progressLabel.textColor = [UIColor blackColor];
    }
    return _progressLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}


@end
