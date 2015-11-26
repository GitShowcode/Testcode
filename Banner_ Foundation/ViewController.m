//
//  ViewController.m
//  Banner_ Foundation
//
//  Created by jiapeixin on 15/11/25.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "ViewController.h"
#import "Basic_Banner_Gencare.h"
#import "NewCommonObj.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Basic_Banner_Gencare*  banner=[[Basic_Banner_Gencare alloc] initWithFrame:CGRectMake(10, 20+20, SCREEN_WIDTH-20, 300)];
    [self.view addSubview:banner];
    banner.backgroundColor=[UIColor whiteColor];
    //修改了颜色
    
    UIView *heheview;
    
    
    NSMutableArray *services=[NSMutableArray arrayWithCapacity:10];
    
    [services addObject:@"http://www.careliver.cn/Public/img/banner1.png"];
    [services addObject:@"http://www.careliver.cn/Public/img/banner2.png"];
    [services addObject:@"http://www.careliver.cn/Public/img/banner3.png"];
    
    
    NSMutableArray *serviceimgs=[NSMutableArray arrayWithCapacity:10];
   
    for (int i=0; i<services.count; i++) {
    
        NewCommonObj *commonobj=[NewCommonObj new];
        commonobj.imgurl=services[i];
        commonobj.newid=@"1";
        [serviceimgs addObject:commonobj];
        
    }

    //0 不关闭垃圾加载
    NSMutableArray *locals=[NSMutableArray arrayWithCapacity:10];
    [locals addObject:@"u=975193274,1966237050&fm=21&gp=0.jpg"];
    [locals addObject:@"u=1615482946,3641545976&fm=21&gp=0.jpg"];
    [locals addObject:@"u=3337457456,2351338921&fm=21&gp=0.jpg"];
    [locals addObject:@"u=4048534258,1414738821&fm=21&gp=0.jpg"];
    [locals addObject:@"u=516038842,4000674297&fm=21&gp=0.jpg"];
   // [banner setdatasforservice:serviceimgs andinterval:5 opendownload:1];
    NSMutableArray *localimgs=[NSMutableArray arrayWithCapacity:10];
    
    for (int i=0; i<locals.count; i++) {
        NewCommonObj *common=[NewCommonObj new];
        common.imgurl=locals[i];
        common.newid=[NSString stringWithFormat:@"common-%d",i];
        [localimgs addObject:common];
    }
    
    __weak   Basic_Banner_Gencare *bannerself=banner;
    bannerself.tapblock=^(long i){
        NewCommonObj *common=localimgs[i];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:common.newid message:[NSString stringWithFormat:@"%ld",i] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    };
    [banner setdatasforlocal:localimgs andinterval:5];

//    banner.newdownloadimgs=^(NSMutableArray *zimgs){
//                for (UIView *aview in bannerself.fixScrollview.subviews) {
//                    //建议 SDWebImage
//                    if ([aview isKindOfClass:[UIImageView class]]) {
//                        UIImageView *IMG=(UIImageView *)aview;
//                        BACK((^(){
//                            NewCommonObj *common=IMAGE(zimgs[IMG.tag]);
//                            
//                                                  
//                            NSURL *url=[NSURL URLWithString:common.imgurl];
//                            NSData *data=[NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:NULL];
//                            MAIN(^(){
//                                UIImage *newimage=[UIImage imageWithData:data];
//                                IMG.image=newimage;
//                            });
//                        }));
//                    }
//                }
//    };
//    [banner setdatasforservice:serviceimgs andinterval:2 opendownload:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
