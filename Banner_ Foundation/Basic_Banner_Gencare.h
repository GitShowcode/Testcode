//
//  Basic_Banner_Gencare.h
//  Banner_ Foundation
//
//  Created by jiapeixin on 15/11/25.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gencare.h"
#import "NewCommonObj.h"
typedef void (^ ReloadDownload) (NSMutableArray *imgs);
typedef void (^ TapImageView) (long i);
@interface Basic_Banner_Gencare : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *fixScrollview;

-(id)initWithFrame:(CGRect)frame;

-(void)setdatasforlocal:(NSMutableArray *)imgs andinterval:(int)ainterval;
-(void)setdatasforservice:(NSMutableArray *)imgs andinterval:(int)ainterval opendownload:(BOOL)isopen;


@property (nonatomic,assign)long allpagecount;

@property (nonatomic,strong)NSMutableArray *myimgs;
@property (nonatomic,strong)NSTimer *myTimer;
@property (nonatomic,assign)long myinterval;
@property (nonatomic,strong)UIPageControl *mypagecontrol;
@property (nonatomic,copy)TapImageView tapblock;
@property (nonatomic,copy)ReloadDownload newdownloadimgs;

@end
