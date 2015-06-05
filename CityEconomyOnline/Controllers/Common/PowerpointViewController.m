//
//  PowerpointViewController.m
//  Powerpoint
//
//  Created by a on 13-12-9.
//  Copyright (c) 2013年 liyongqiang. All rights reserved.
//

#import "PowerpointViewController.h"
#import "ImageRequest.h"
#define  IMAGE_WITHD 1024
#import "HttpImageView.h"
#import  "CacheData.h"
@interface PowerpointViewController ()

@end

@implementation PowerpointViewController
@synthesize listScrollView = _listScrollView ;
@synthesize showButton = _showButton ;
@synthesize  addButton= _addButton ;
@synthesize index =  _index ;
@synthesize  type = _type ;
@synthesize  viewController = _viewController ;
//@synthesize  locationButton = _locationButton ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(id)initWithImageModel:(ImageModel *)_imageModel
{
    self = [super init];
    if (self) {
        self->imageModel = _imageModel ;
        _type = -1 ;
        
    }
    return self ;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
	// Do any additional setup after loading the view.
    self->onceTime = 1.0* [[NSUserDefaults standardUserDefaults] integerForKey:kDefaultSliderTime];
    self.view.backgroundColor = [UIColor blackColor];
    _index = 0;
    navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    isShowNavgation = YES ;
    
    navTabBar.alpha = 0.8 ;
    
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
//    [self.view addSubview:navTabBar];
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(430, 0, 250, 40)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = [UIColor whiteColor];
    
    
    UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 5, 40, 35)];
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(7.5, 8, 7.5,8) ;
    [homeBtn setImage :[UIImage imageNamed:@"home_01.png"] forState:UIControlStateNormal];
    
    [homeBtn addTarget:self action:@selector(backHomeClickView:) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:homeBtn];
    //上面的还回
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 41, 30)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    [navTabBar addSubview:titleLable];
    
   
    self->timerIndex = 0 ;
    // 对应时间 关系
    [self initTimer];
    
    self->imageArray = [[NSMutableArray alloc]init];
    self->myImageViews = [[NSMutableArray alloc]init];

    _listScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];

    _listScrollView.showsHorizontalScrollIndicator = NO;
    _listScrollView.pagingEnabled = YES;
    _listScrollView.delegate = self ;
    [self.view addSubview:_listScrollView];
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPrompt:)];
    [_listScrollView addGestureRecognizer:tapGesture];
    
    
    

    
    _showButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 340, 50, 50)];
    [_showButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];

    [_showButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showButton];

//    
    hud = [[MBProgressHUD alloc]init];

    self->bigImages = [[NSMutableArray alloc]init];
 [self.view addSubview:navTabBar];
   [self httpGetImageData];
//
    
    
    
    
}
// 隐藏状态栏


- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"-----:");
    [myTimer invalidate];
    
}
-(void)showPrompt:(UITapGestureRecognizer *)tapGesture
{
    if (_showButton.hidden == NO) {
        
        if (isShowNavgation == YES) {
             [UIView animateWithDuration:0.4 animations:^{
                 
                 navTabBar.frame = CGRectMake(0, -44, 1024, 44) ;
                 
             }];
            isShowNavgation = NO ;
            
        } else {
            [UIView animateWithDuration:0.4 animations:^{
                
                  navTabBar.frame = CGRectMake(0, 0, 1024, 44) ;
            }];
            isShowNavgation = YES ;
            
        }
        return ;
    }
    [myTimer setFireDate:[NSDate distantFuture]];
    [self addPlayView];
}
// 获的网络图片
-(void)httpGetImageData
{
    ImageRequest * request = [[ImageRequest alloc]init];
    
    [request requestBigImageWithArray:self->bigImages andUsage:1 andCity:_type andLandscape:[self->imageModel.landscape_id integerValue] onSucceed:^{
        if ([self->bigImages count] >= 1) {
           BigImage * myBigImage = [bigImages objectAtIndex:_index];
            HttpImageView  * myImageView = [[HttpImageView alloc]initWithFrame:CGRectMake((_index)*IMAGE_WITHD, 0, 1024, 768)];
            [myImageView  setImage:[UIImage imageNamed:@"loading1.gif"] andImageUrl:myBigImage.imageUrl];
            _listScrollView.contentSize = CGSizeMake(1025, 724) ;
//            [self->myImageViews addObject:myImageView];
            [_listScrollView addSubview:myImageView];
            _index ++ ;
            
        }
        if ([self->bigImages count] >= 2) {
             BigImage * myBigImage = [bigImages objectAtIndex:_index];
            HttpImageView  * myImageView = [[HttpImageView alloc]initWithFrame:CGRectMake((_index)*IMAGE_WITHD, 0, 1024, 768)];
            [myImageView  setImage:[UIImage imageNamed:@"loading1.gif"] andImageUrl:myBigImage.imageUrl];
            _listScrollView.contentSize = CGSizeMake(1025, 724) ;
//            [self->myImageViews addObject:myImageView];
            [_listScrollView addSubview:myImageView];
            _index ++ ;

        }
        
        [hud hide:YES];
        
    } onFailed:^{
        [hud hide:YES];
        [self initprompt];
        
    }];
    
}
- (void)initTimer
{
    NSNumber * number1 = [[NSNumber alloc]initWithDouble:2.0];
    NSNumber * number2 = [[NSNumber alloc]initWithDouble:3.0];
    NSNumber * number3 = [[NSNumber alloc]initWithDouble:5.0];
    NSNumber * number4 = [[NSNumber alloc]initWithDouble:10.0];
    NSNumber * number5 = [[NSNumber alloc]initWithDouble:15.0];
    NSNumber * number6 = [[NSNumber alloc]initWithDouble:30.0];
    NSNumber * number7 = [[NSNumber alloc]initWithDouble:60.0];
    self->timerArray = @[number1,number2,number3,number4,number5,number6,number7];
}
-(void) initprompt
{
    CommonUtils   * utils = [[CommonUtils alloc]init];
    [utils alertWithMessage:@"网络有点不给力！" andView:self.view];
}
-(void)setImageArray:(NSMutableArray *)_imageArray
{
   
}
// 结束幻灯片
-(void)backHome
{
    
    [bigImages removeAllObjects];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        self->myImageViews =nil ;
        self->timerArray = nil;
        self->imageArray = nil ;
        self->bigImages = nil ;
        
    }];
    
    
}
 // 幻灯片提示框
-(void)promptView:(NSString * )messsage
{
   MBProgressHUD * mbHud = [[MBProgressHUD alloc]init];
    mbHud.mode = MBProgressHUDModeCustomView;
    UILabel * myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    myLabel.font = [UIFont systemFontOfSize:20];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.backgroundColor = [UIColor clearColor];
    
    myLabel.text = messsage ;
    myLabel.textAlignment = NSTextAlignmentCenter ;
    mbHud.customView = myLabel;
    [self.view addSubview:mbHud];
    [mbHud show:YES];
    [mbHud hide:YES afterDelay:1.5];
    
}
//放映 幻灯片
-(void)showImage:(UIButton *)sender
{
//    [self addPlayView];
    [self promptView:@"幻灯片"];
    navTabBar.frame = CGRectMake(0, -44, 1024, 44) ;
    isShowNavgation = NO ;
    
    [_listScrollView addGestureRecognizer:tapGesture];
    NSTimeInterval  time = [[self->timerArray objectAtIndex:self->onceTime] doubleValue];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:time  target:self selector:@selector(palyImages) userInfo:nil repeats:YES];
    _showButton.hidden = YES ;
    _addButton.hidden = YES ;
//    _locationButton.hidden = YES ;
    
    
}
-(void)palyImages
{
//    NSLog(@"timerIndex--%i",timerIndex);
    _listScrollView.contentOffset = CGPointMake(timerIndex * 1024, 0) ;
    timerIndex ++;
    if (timerIndex >= _index) {
    
        [myTimer invalidate];
        [self promptView:@"幻灯片播放完成"];
        
        _showButton.hidden = NO ;
        _addButton.hidden = NO ;
//        _locationButton.hidden = NO ;
        timerIndex = 0;
    }
}
// 添加我的城市的按钮
-(void)addImage:(UIButton *)sender
{
//    [sender setUserInteractionEnabled:NO];
    [self promptView:@"添加所在城市"];
    NSMutableArray * array = [CacheData readCacheMemory:OWNER_IMAGES];
//    [array removeAllObjects];
//    NSInteger indexImage = _listScrollView.contentOffset.x / 1024;
    NSMutableArray * images = [[NSMutableArray alloc]initWithArray:array];

    [CacheData writeCacheMemory:images andKeyString:OWNER_IMAGES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OwnerImages" object:nil];
    
    
//    NSLog(@"我那个就是个解释----%i",index);
}

// 地图定位 按钮
-(void)locationImage:(UIButton *)sender
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  UIscrollView delegates methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isShowNavgation == YES) {
        [UIView animateWithDuration:0.4 animations:^{
            
            navTabBar.frame = CGRectMake(0, -44, 1024, 44) ;
            
        }];
        isShowNavgation = NO ;
    }
    
    NSInteger  poinx =  scrollView.contentOffset.x;
    if ((_index-2)* IMAGE_WITHD <= poinx) {
        
        NSLog(@"----%i",_index);
        if (self->bigImages.count <= _index) {
            return ;
        }
       scrollView.contentSize = CGSizeMake(IMAGE_WITHD*(_index+1), 724);
        HttpImageView  * myImageView = [[HttpImageView alloc]initWithFrame:CGRectMake((_index)*IMAGE_WITHD, 0, 1024, 768)];
        NSLog(@"^^^^^^^^^%i",_index);
        if ([bigImages count] > _index) {
            
            
           BigImage * myBigImage = [bigImages objectAtIndex:_index ];
            
            NSLog(@"5666666%@",myBigImage.imageUrl);
            [myImageView setImage:[UIImage imageNamed:@"loading1.gif"] andImageUrl:myBigImage.imageUrl];
            [self->myImageViews addObject:myImageView];
            _index ++ ;
            [scrollView addSubview:myImageView];
        }
        
        
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView     
{
    NSInteger myIndex = scrollView.contentOffset.x / 1024 ;
    if ([bigImages count] > myIndex) {
        BigImage * myBigImage = [bigImages objectAtIndex:myIndex ];
        NSString * title = myBigImage.imageTitle ;
        title = [title stringByAppendingFormat:@" (%i/%i)",myIndex + 1 ,[bigImages count]];
        titleLable.text = title ;
    }
    
}
// 提示播放按钮
-(void)addPlayView
{
    
    
    UIView *  promptview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 230, 50)];
    UIButton * stopButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 100, 30)];
    [stopButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
//    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    UIButton * gonoButton = [[UIButton alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
    [gonoButton setImage:[UIImage imageNamed:@"gono.png"] forState:UIControlStateNormal];
    [gonoButton addTarget:self action:@selector(gonoClick:) forControlEvents:UIControlEventTouchUpInside];
    [stopButton addTarget:self action:@selector(stopClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [promptview addSubview:stopButton];
    [promptview addSubview:gonoButton];
    UILabel * frontLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 40)];
    frontLabel.text = @"幻灯片";
    frontLabel.font = [UIFont systemFontOfSize:24];
    frontLabel.textColor = [UIColor whiteColor];
    

     hud1 = [[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
     hud1.mode = MBProgressHUDModeCustomView;
//    hud1.alpha = 0.2 ;
//    hud1.yOffset = 100 ;
    hud1.customView = promptview ;
    hud1.labelText = @"幻灯片";
    hud1.labelFont = [UIFont systemFontOfSize:20];
    [self.view addSubview:hud1];
     [hud1 show:YES];
//    [hud1 hide:YES afterDelay:2];
    
    
}
//点击 继续
-(void)gonoClick:(UIButton * )sender
{
    
    [hud1 hide:YES];
    [myTimer setFireDate:[NSDate date]];
    
    NSLog(@"---gonoLClick");
    
}
// 点击 停止
-(void)stopClick:(UIButton *)sender
{
    [hud1 hide:YES];
    [myTimer invalidate];
    _showButton.hidden = NO ;
    _addButton.hidden = NO ;
    NSLog(@"----stopClick");
    
}

-(void)backHomeClickView:(UIButton *)sender
{
        [self dismissViewControllerAnimated:NO completion:^{
            
            [_viewController dismissViewControllerAnimated:NO completion:^{
                   [[NSNotificationCenter defaultCenter]postNotificationName:BACK_HOME object:nil];
            }];
        }];
}
@end
