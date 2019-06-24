//
//  LQBannerScroll.m
//  LQBannerScroll
//
//  Created by zhengliqiang on 2017/11/6.
//  Copyright © 2017年 zhengliqiang. All rights reserved.
//
//这是一个用Collecionview创建的轮播图
#import "LQBannerScroll.h"
#import "LQBannerCell.h"

@interface LQBannerScroll ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionview;//
@property (nonatomic,strong)NSMutableArray * dataArray;//
@property (nonatomic,strong)NSTimer * timer;//
@property (nonatomic,strong)UIPageControl * pageCV;//
@property (nonatomic,assign)NSInteger currentSize;//
@end

static NSString * identifier = @"LQBannerCell";
@implementation LQBannerScroll


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentSize = 1;
        [self loadCollectionview];
    }
    return self;
}

//创建Colectionview
-(void)loadCollectionview{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.bounces = NO;
    self.collectionview.pagingEnabled = YES;
    self.collectionview.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionview];
    [self.collectionview registerClass:[LQBannerCell class] forCellWithReuseIdentifier:identifier];
    self.collectionview.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    [self addPageController];
    [self addTimer];
}
-(void)addPageController{
    self.pageCV = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height-20, 100, 20)];
    self.pageCV.numberOfPages = self.dataArray.count;
    self.pageCV.currentPage = 0;
    self.pageCV.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    [self addSubview:self.pageCV];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count+2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LQBannerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.bannerImage.image = [UIImage imageNamed:self.dataArray[self.dataArray.count-1]];
    }else if (indexPath.row == self.dataArray.count + 1) {
        cell.bannerImage.image = [UIImage imageNamed:self.dataArray[0]];
   }else{
    cell.bannerImage.image = [UIImage imageNamed:self.dataArray[indexPath.row-1]];
       
   }
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.currentSize = scrollView.contentOffset.x/self.frame.size.width;
    
    if (self.currentSize == self.dataArray.count+1) {
        [self.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
            self.currentSize = 1;
    }else if (self.currentSize == 0){
        [self.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        self.currentSize = self.dataArray.count;
        
    }
   self.pageCV.currentPage = self.currentSize-1;
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(starScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:(NSRunLoopCommonModes)];
    
}
//删除定时器
-(void)deleteTimer{
    [self.timer invalidate];
    self.timer = nil;
}
//开始滚动
-(void)starScroll{
    self.currentSize++;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentSize inSection:0];
    [self.collectionview scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x == (self.dataArray.count+1)*self.frame.size.width) {
            [self.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        self.currentSize = 1;
    }
        self.pageCV.currentPage = self.currentSize-1;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self deleteTimer];
    self.currentSize = scrollView.contentOffset.x/self.frame.size.width;
    if (self.currentSize == self.dataArray.count+1) {
        [self.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        self.currentSize = 1;
    }else if (self.currentSize == 0){
        [self.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        self.currentSize = self.dataArray.count;
    }
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
        
    }
    return _dataArray   ;
}





@end
