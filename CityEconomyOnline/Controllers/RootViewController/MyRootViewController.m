 //
//  MyRootViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "MyRootViewController.h"

typedef enum TabBarButtonTags {
    TabBarButtonHomeTag = 101,
    TabBarButtonTraveleTag,
    TabBarButtonTalkTag,
    TabBarButtonMicroCityTag,
    TarBarButtonCityTipsTag
}TabBarButton;

@interface MyRootViewController ()

@end

@implementation MyRootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.frame = CGRectMake(0, 20, 1024, 748);
    self.view.backgroundColor = RGBCOLOR(41, 41, 41);
    // 最上面的状态栏
    [self initheadView];
    //初始化左边的按钮
    [self initLeftMenuButtons];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHomeClick) name:BACK_HOME object:nil];
    
    //初始化右边的视图
    [self initRightContentViews];
}
-(void)initheadView
{
    self->headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(450, 20, 150, 26)];
    UIView * seperatorView = [[[UIView alloc] initWithFrame:CGRectMake(90, 59, 1024, 1)] autorelease];
    seperatorView.backgroundColor = RGBCOLOR(48, 48, 48);
    self->headImageView.contentMode = UIViewContentModeScaleAspectFit ;
    [self->headImageView setImage:[UIImage imageNamed:@"cityonline.png"]];
    [self.view addSubview:self->headImageView];
    [self.view addSubview:seperatorView];
    
}
- (void)dealloc
{
    [_homeViewController release];
    _homeViewController = nil;
    [_travelViewController release];
    _travelViewController = nil;
    [_talkCityViewController release];
    _talkCityViewController = nil;
    [_microViewController release];
    _microViewController = nil;
    [_cityTipsViewController release];
    _cityTipsViewController = nil;
    
    [super dealloc];
}
// 左边按钮
- (void)initLeftMenuButtons
{
    _leftMenuView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, height(self.view) +44)] autorelease];
    _leftMenuView.backgroundColor = RGBCOLOR(51, 50, 50);
    [self.view addSubview:_leftMenuView];
  
    //首页
    _homeButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0, 44, kLeftViewWidth, 115) nomalImage:@"Menu_Home.png" hightImage:@"Menu_HomeSelected.png"  target:self action:@selector(buttonClicked:)];
    _homeButton.tag = TabBarButtonHomeTag;
    [_homeButton setSelected:YES];
    [_leftMenuView addSubview:_homeButton];
    
    //城市旅游
    _travelButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0,44 + height(_homeButton), kLeftViewWidth, height(_homeButton)) nomalImage:@"Menu_Travel.png" hightImage:@"Menu_TravelSelected.png" target:self action:@selector(buttonClicked:)];
    _travelButton.tag = TabBarButtonTraveleTag;
    [_leftMenuView addSubview:_travelButton];
    
    //对话城市
    _talkButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0,44 +14 + 2 * height(_homeButton), kLeftViewWidth, height(_homeButton)) nomalImage:@"Menu_Talk.png" hightImage:@"Menu_TalkSelected.png" target:self action:@selector(buttonClicked:)];
    _talkButton.tag = TabBarButtonTalkTag;
    [_leftMenuView addSubview:_talkButton];
    
    //微城市
    _microCityButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0,28 + 44 + 3*height(_homeButton), kLeftViewWidth, height(_homeButton)) nomalImage:@"Menu_MicroCity.png" hightImage:@"Menu_MicroCitySelected.png" target:self action:@selector(buttonClicked:)];
    _microCityButton.tag  = TabBarButtonMicroCityTag;
    [_leftMenuView addSubview:_microCityButton];
    
    //城市锦囊
    _cityTipsButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0,48 + 44 + 4*height(_homeButton), kLeftViewWidth, height(_homeButton)) nomalImage:@"Menu_Tips.png" hightImage:@"Menu_TipsSelected.png" target:self action:@selector(buttonClicked:)];
    _cityTipsButton.tag = TarBarButtonCityTipsTag;
    [_leftMenuView addSubview:_cityTipsButton];
    

//    [_homeButton setTitle:@"首页" forState:UIControlStateNormal];
//    [_travelButton setTitle:@"城市旅游" forState:UIControlStateNormal];
//     [_talkButton setTitle:@"对话城市" forState:UIControlStateNormal];
//    [_microCityButton setTitle:@"微城市" forState:UIControlStateNormal];
//    [_cityTipsButton setTitle:@"城市锦囊" forState:UIControlStateNormal];

}

// 右边视图初始化

- (void)initRightContentViews
{
    _homeViewController = [[HomeViewController alloc] initWithFrame:kRightFrame];
    
    [self.view addSubview:_homeViewController.view];
   [_homeViewController viewWillAppear:YES];
    
    _travelViewController = [[TravelViewController alloc] init];
    _talkCityViewController = [[MicroCityViewController alloc] initWithType:TalkCity];
    _microViewController = [[MicroCityViewController alloc] initWithType:MicroCity];
    _cityTipsViewController = [[CityTipsViewController alloc] init];
    
//    [self setNavigationTitle:TabBarButtonHomeTag];
    self.navigationController.navigationBarHidden = YES ;
    _homeViewController.navString = navTitle;
}
// 接到通知回到主页
-(void)backHomeClick
{
    [self buttonClicked:_homeButton];
    
}
- (void)buttonClicked:(UIButton *)sender
{
    [self clearSelected];
    sender.selected = YES;
//    NSLog(@"----****_____&&&&-----");
    switch (sender.tag) {
        case TabBarButtonHomeTag:
            [_travelViewController.view removeFromSuperview];
            [_talkCityViewController.view removeFromSuperview];
            [_microViewController.view removeFromSuperview];
            [_cityTipsViewController.view removeFromSuperview];
            
            [self.view addSubview:_homeViewController.view];
            [_homeViewController.view setFrame:kRightFrame];
//            [_homeViewController viewWillAppear:YES];
            break;
        case TabBarButtonTraveleTag:
            [_homeViewController.view removeFromSuperview];
            [_talkCityViewController.view removeFromSuperview];
            [_microViewController.view removeFromSuperview];
            [_cityTipsViewController.view removeFromSuperview];
            
            [self.view addSubview:_travelViewController.view];
            [_travelViewController.view setFrame:kRightFrame];
//            [_travelViewController viewWillAppear:YES];
            break;
        case TabBarButtonTalkTag: //  城市 对话 ；
            [_homeViewController.view removeFromSuperview];
            [_travelViewController.view removeFromSuperview];
            [_microViewController.view removeFromSuperview];
            [_cityTipsViewController.view removeFromSuperview];
            
            [self.view addSubview:_talkCityViewController.view];
            [_talkCityViewController.view setFrame:kRightFrame];
//            [_talkCityViewController viewWillAppear:YES];
            break;
        case TabBarButtonMicroCityTag: // 微城市
            [_homeViewController.view removeFromSuperview];
            [_travelViewController.view removeFromSuperview];
            [_talkCityViewController.view removeFromSuperview];
            [_cityTipsViewController.view removeFromSuperview];
            
            [self.view addSubview:_microViewController.view];
            [_microViewController.view setFrame:kRightFrame];
//            [_microViewController viewWillAppear:YES];
            break;
        case TarBarButtonCityTipsTag: // 城市 锦囊
            [_homeViewController.view removeFromSuperview];
            [_travelViewController.view removeFromSuperview];
            [_talkCityViewController.view removeFromSuperview];
            [_microViewController.view removeFromSuperview];
 
            [self.view addSubview:_cityTipsViewController.view];
            [_cityTipsViewController.view setFrame:kRightFrame];
//            [_cityTipsViewController viewWillAppear:YES];
            break;
    }
    [self setNavigationTitle:sender.tag];
}

- (void)clearSelected
{
    _homeButton.selected = NO;
    _travelButton.selected = NO;
    _talkButton.selected = NO;
    _microCityButton.selected = NO;
    _cityTipsButton.selected =NO;
}

- (void)setNavigationTitle:(NSInteger)tag
{
        switch (tag) {
        case TabBarButtonHomeTag:
            navTitle = @"cityonline.png";
            break;
        case TabBarButtonTraveleTag:
            navTitle = @"travelcity.png";
            break;
        case TabBarButtonTalkTag:
            navTitle = @"talkcity_01.png";
            break;
        case TabBarButtonMicroCityTag:
            navTitle = @"moftCity.png" ;
            break;
        case TarBarButtonCityTipsTag:
            navTitle = @"citytips.png";
            break;
    }
    UIImage * image  =[UIImage imageNamed:navTitle];
    [self->headImageView setImage:image];
    
    

    
}

#pragma mark - 旋转处理

//iOS (2.0 and later)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

//ios 6.0 and later
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


@end
