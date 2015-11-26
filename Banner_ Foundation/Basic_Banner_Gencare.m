//
//  Basic_Banner_Gencare.m
//  Banner_ Foundation
//
//  Created by jiapeixin on 15/11/25.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "Basic_Banner_Gencare.h"
#define Zero_Macro 10086+1
@implementation Basic_Banner_Gencare
//-(id)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        
//    }
//    return self;
//}
-(void)initsubscr:(int)type andimgs:(NSMutableArray *)imgs andopen:(BOOL)isopen{
    self.fixScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _fixScrollview.delegate=self;
    _fixScrollview.pagingEnabled=YES;
    _fixScrollview.tag=Zero_Macro;
    
    self.fixScrollview.backgroundColor=[UIColor blueColor];
    [self addSubview:self.fixScrollview];
    
   
    
    [imgs insertObject:[imgs lastObject] atIndex:0];
    [imgs addObject:imgs[1]];
    long mycount=imgs.count;
    _fixScrollview.contentSize=CGSizeMake(self.frame.size.width*mycount, self.frame.size.height);

    for (int i=0; i<imgs.count; i++) {
        UIImageView *IMG=[UIImageView new];
        IMG.frame=CGRectMake(self.frame.size.width*i,0 , self.frame.size.width, self.frame.size.height);
        [IMG setClipsToBounds:YES];
        IMG.contentMode=UIViewContentModeScaleAspectFill;
        [_fixScrollview addSubview:IMG];
        IMG.tag=i;
        IMG.userInteractionEnabled=YES;
        [IMG addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showtap:)]];
        
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, 60)];
        label.text=[NSString stringWithFormat:@"%d",i];
        [IMG addSubview:label];
        label.font=[UIFont systemFontOfSize:30];
        
        NewCommonObj *common=imgs[i];
        
        if (type==1) {
            //本地
            IMG.image=[UIImage imageNamed:common.imgurl];
        }
        else{
            //网络
            if (isopen==1) {
                if (self.newdownloadimgs) {
                    //count +2
                    self.newdownloadimgs(imgs);
                }
            }
            else{
                //垃圾下载
               BACK(^(){
                  NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:common.imgurl] options:NSDataReadingMappedIfSafe error:NULL];
                   MAIN(^(){
                       UIImage *newimage=[UIImage imageWithData:data];
                       IMG.image=newimage;
                   });
                });
            }
        }
    }
    _fixScrollview.contentOffset=CGPointMake(self.frame.size.width, 0);
    
    self.mypagecontrol=[[UIPageControl alloc] init];
    self.mypagecontrol.frame=CGRectMake(SCREEN_WIDTH/2.0-50, self.frame.size.height-20-20, 100, 20);
    self.mypagecontrol.numberOfPages=imgs.count-2;
    self.mypagecontrol.currentPage=0;
    self.mypagecontrol.pageIndicatorTintColor=[UIColor purpleColor];
    self.mypagecontrol.currentPageIndicatorTintColor=[UIColor orangeColor];
    [self addSubview:self.mypagecontrol];
    

    if (self.newdownloadimgs) {
        self.newdownloadimgs(imgs);
    }
   [self startTimer];
    
}
-(void)setdatasforlocal:(NSMutableArray *)imgs andinterval:(int)ainterval{

    self.myinterval=ainterval;
    self.allpagecount=imgs.count;
    [self initsubscr:1 andimgs:imgs andopen:1];

    

}
-(void)setdatasforservice:(NSMutableArray *)imgs andinterval:(int)ainterval opendownload:(BOOL)isopen{
    self.myinterval=ainterval;
    self.allpagecount=imgs.count;
    [self initsubscr:2 andimgs:imgs andopen:isopen];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.tag==Zero_Macro) {
        if (scrollView.contentOffset.x==0) {
            scrollView.contentOffset=CGPointMake(self.frame.size.width*self.allpagecount, 0);
            
        }
        NSLog(@"%f",scrollView.contentOffset.x);
        
        if (scrollView.contentOffset.x == self.frame.size.width*(self.allpagecount+1)) {
            scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
        }

        float xx=scrollView.contentOffset.x/self.frame.size.width;
        self.mypagecontrol.currentPage=xx-1;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self stopTimer];
    [self startTimer];


}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.tag==Zero_Macro) {
        
        [NSThread sleepForTimeInterval:.2];
        if (scrollView.contentOffset.x==0) {
            scrollView.contentOffset=CGPointMake(self.frame.size.width*self.allpagecount, 0);
            
        }
        NSLog(@"%f",scrollView.contentOffset.x);
        
        if (scrollView.contentOffset.x == self.frame.size.width*(self.allpagecount+1)) {
            scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
        }
        
        float xx=scrollView.contentOffset.x/self.frame.size.width;
        self.mypagecontrol.currentPage=xx-1;
        
        
    }
    
    // 3  1  2  3  1
    
}
-(void)autochangepage:(NSTimer *)timer{
    [NSThread sleepForTimeInterval:.1];
    float newX=self.fixScrollview.contentOffset.x+self.frame.size.width;
    [self.fixScrollview setContentOffset:CGPointMake(newX, 0) animated:YES];

}
-(void)startTimer{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:_myinterval target:self selector:@selector(autochangepage:) userInfo:nil repeats:YES];
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];

}
-(void)stopTimer{
    [self.myTimer invalidate];
    self.myTimer=nil;

}
-(void)showtap:(UITapGestureRecognizer *)tap{
    UIImageView *IMG=(UIImageView *)tap.view;
    long kkkk=self.allpagecount;
    
    
    //git 变了么
    // 0 1  2  3  4  5 6
    if (self.tapblock) {
        if (IMG.tag==0) {
            
           // self.tapblock(self.allpagecount+2-1);

        }
        else if (IMG.tag==self.allpagecount+2-1){
          //  self.tapblock(0);

        }
        else{
            
        }
        self.tapblock(IMG.tag);

    }
}
@end
