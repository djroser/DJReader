//
//  ViewController.m
//  DJBookReader
//
//  Created by user on 15/7/20.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "ViewController.h"
#import "BookCell.h"
#import "PCReaderViewController.h"
#import "HeadView.h"
@interface ViewController ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"aizaixianjingderizi.jpeg",@"anshizhangda.jpeg",@"bubizhidaowoshishui.jpeg",@"dangnigudannihuixiangqishui.jpeg",@"hudielaiguozheshijie.jpeg",@"liaiyigeIDdejuli.jpeg",@"shalou.jpeg",@"shinian.jpeg",@"tangyi.jpeg",@"tiaopin.jpeg",@"wobushinideyuanjia.jpeg",@"woyaowomenzaiyiqi.jpeg",@"xiaofudequnbai.jpeg",@"xiaoyaodejinsechengbao.jpeg",@"zuishuxidemoshengren.jpeg",@"zuoer.jpg",@"zuoerzhongjie.jpeg",@"aizaixianjingderizi.jpeg", nil];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.collectionView.frame collectionViewLayout:layout];
    
    
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake(100, 124);
    layout.sectionInset = UIEdgeInsetsMake(0, 50, 10, 20);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    
    
    
    self.collectionView.backgroundView = [[UIView alloc]initWithFrame:self.collectionView.bounds];
    
    UIImageView *backGroundView = [[UIImageView alloc]initWithFrame:self.collectionView.bounds];
    
    backGroundView.image = [UIImage imageNamed:@"book.jpg"];
    
    backGroundView.contentMode = UIViewContentModeScaleAspectFill;

    
    [self.collectionView.backgroundView addSubview:backGroundView];
    

    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[BookCell class] forCellWithReuseIdentifier:@"BookCell"];

    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    
    cell.bookPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.item]]];
    
    
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)sender
{
    PCReaderViewController *reader = segue.destinationViewController;
    reader.bookNum = sender.item;
    
    NSURL *url;
    
    if (sender.item == 0) {
        url = [self setBookTextWithStr:@"aizaixianjingderizi"];
    } else if (sender.item == 1){
        url = [self setBookTextWithStr:@"anshizhangda"];
    } else if (sender.item == 2) {
        url = [self setBookTextWithStr:@"bubizhidaowoshishui"];
    } else if (sender.item == 3) {
        url = [self setBookTextWithStr:@"dangnigudannihuixiangqishui"];
    } else if (sender.item == 4) {
        url = [self setBookTextWithStr:@"hudielaiguozheshijie"];
    } else if (sender.item == 5) {
        url = [self setBookTextWithStr:@"liaiyigeIDdejuli"];
    } else if (sender.item == 6) {
        url = [self setBookTextWithStr:@"shalou"];
    } else if (sender.item == 7) {
        url = [self setBookTextWithStr:@"shinian"];
    } else if (sender.item == 8) {
        url = [self setBookTextWithStr:@"tangyi"];
    } else if (sender.item == 9) {
        url = [self setBookTextWithStr:@"tiaopin"];
    } else if (sender.item == 10) {
        url = [self setBookTextWithStr:@"wobushinideyuanjia"];
    } else if (sender.item == 11) {
        url = [self setBookTextWithStr:@"woyaowomenzaiyiqi"];
    } else if (sender.item == 12) {
        url = [self setBookTextWithStr:@"xiaofudequnbai"];
    } else if (sender.item == 13) {
        url = [self setBookTextWithStr:@"xiaoyaodejinsechengbao"];
    } else if (sender.item == 14) {
        url = [self setBookTextWithStr:@"zuishuxidemoshengren"];
    } else if (sender.item == 15) {
        url = [self setBookTextWithStr:@"zuoer"];
    } else if (sender.item == 16) {
        url = [self setBookTextWithStr:@"zuoerzhongjie"];
    } else if (sender.item == 17) {
        url = [self setBookTextWithStr:@"aizaixianjingderizi"];
    } else {
        return ;
    }

    [reader loadText:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
    
}

- (NSURL *)setBookTextWithStr:(NSString *)str
{
    return [[NSBundle mainBundle]URLForResource:str withExtension:@"txt"];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"PCRead" sender:indexPath];
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    HeadView *headView;
//    
//    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
//        
//        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
//        headView.backgroundColor = [UIColor redColor];
//        
//        
//    } else if ([kind isEqual:UICollectionElementKindSectionFooter]) {
//        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"head" forIndexPath:indexPath];
//        headView.backgroundColor = [UIColor blueColor];
//    }
//    
//            return headView;
//}
//




@end
