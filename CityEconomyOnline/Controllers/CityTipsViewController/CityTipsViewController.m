//
//  CityTipsViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityTipsViewController.h"
#import "TipsInfoViewController.h"
#import "SecretTipsViewController.h"
#import "ImageRequest.h"
#import "CityImage.h"
@interface CityTipsViewController ()

@end

@implementation CityTipsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = kRightFrame;
    SecretTipsViewController * secretTipView  = [[SecretTipsViewController alloc]initWithFrame:CGRectMake(kCityTipsLeftViewWidth, 0, width(self.view) - kCityTipsLeftViewWidth, 702)];
//    [secretTipView.view setFrame:CGRectMake(kCityTipsLeftViewWidth, 0, width(self.view) - kCityTipsLeftViewWidth, 702)];
    self->secretView = secretTipView.view ;
    [self.view addSubview:self->secretView];
    self->secretView.hidden = YES;
    _seperatorView = [[[UIView alloc] initWithFrame:CGRectMake(kCityTipsLeftViewWidth - 1, 0, 1, 702)] autorelease];
    _seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:_seperatorView];
    
    _focusButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0, 20, kCityTipsLeftViewWidth - 2, 42) nomalImage:@"CityTips_FocusCityBtn.png" hightImage:@"CityTips_FocusCityBtnSecretSelected.png" target:self action:@selector(switchCityTips:)];
    _focusButton.tag = 1;
    [self.view addSubview:_focusButton];
    [_focusButton setSelected:YES];
    isSecret = NO ;
    _secretButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(0, 64, kCityTipsLeftViewWidth - 2, 42) nomalImage:@"CityTips_SecretsCityBtn.png" hightImage:@"CityTips_SecretsCityBtnSelected.png" target:self action:@selector(switchCitySecretTips:)];
    _secretButton.tag = 2;
    [self.view addSubview:_secretButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kCityTipsLeftViewWidth, 0, width(self.view) - kCityTipsLeftViewWidth, 702) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //加载更多
    _listArray = [[NSMutableArray alloc] init];
    
//    _tableView.scrollEnabled = NO;
    [self initImageData];
    
}
- (void)initImageData
{
    UIImage * beijingImage = [UIImage imageNamed:@"beijing.png"];
    CityImage * beijingButton = [[CityImage alloc]init];
    beijingButton.image = beijingImage ;
    beijingButton.cityName = @"beijing";
    
    UIImage * shenzhengImage = [UIImage imageNamed:@"Shenzhen.png"];
    CityImage * shenzhengButton = [[CityImage alloc]init];
    shenzhengButton.image = shenzhengImage ;
    shenzhengButton.cityName = @"shenzheng";
    
    UIImage * HongkongImage = [UIImage imageNamed:@"Hongkong.png"];
    CityImage  * hongkongButton = [[ CityImage alloc]init];
    hongkongButton.image = HongkongImage ;
    hongkongButton.cityName = @"HongKong";
    UIImage * shanghaiImage = [UIImage imageNamed:@"Shanghai.png"];
    CityImage * shanghaiButton = [[CityImage alloc]init];
    shanghaiButton.image = shanghaiImage ;
    shanghaiButton.cityName = @"shanghai";
    UIImage * xizhangImage = [UIImage imageNamed:@"XiZang.png"];
    CityImage * xizhangButton = [[CityImage alloc]init];
    xizhangButton.image  = xizhangImage ;
    xizhangButton.cityName = @"xizhang";
    
    UIImage * jinLinImage = [UIImage imageNamed:@"jiLin.png"];
    CityImage * jinLinButton = [[CityImage alloc]init];
    jinLinButton.image = jinLinImage ;
    jinLinButton.cityName = @"jilin";
    
    UIImage * xinjiangImage = [UIImage imageNamed:@"xinjiang.png"];
    CityImage * xinJiangButton = [[CityImage alloc]init];
    xinJiangButton.image = xinjiangImage ;
    xinJiangButton.cityName = @"xinjiang";
    
    UIImage * yunnanImage = [UIImage imageNamed:@"YunNan.png"];
    CityImage * yunNanButton = [[CityImage alloc]init];
    yunNanButton.image = yunnanImage ;
    yunNanButton.cityName = @"yunNan";
    
    UIImage * mengguImage = [UIImage imageNamed:@"MengGu.png"];
    CityImage *  mengguButton  = [[CityImage alloc]init];
    mengguButton.image = mengguImage ;
    mengguButton.cityName = @"menggu";
    
    [_listArray addObject:beijingButton];
//    [_listArray addObject:shenzhengButton];
//    [_listArray addObject:hongkongButton];
//    [_listArray addObject:shanghaiButton];
//    [_listArray addObject:xinJiangButton];
//    [_listArray addObject:jinLinButton];
//    [_listArray addObject:xinJiangButton];
//    [_listArray addObject:yunNanButton];
//    [_listArray addObject:mengguButton];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view.
}

- (void)dealloc
{    
    [super dealloc];
}
-(void)switchCityTips:(UIButton *)sender
{
    _tableView.hidden  = NO ;
    self->secretView.hidden = YES ;
    _focusButton.selected = NO;
    _secretButton.selected = NO;
    sender.selected = YES ;
}
- (void)switchCitySecretTips:(UIButton *)sender
{
    _tableView.hidden  = YES ;
    self->secretView.hidden = NO ;
    _focusButton.selected = NO;
    _secretButton.selected = NO;
    sender.selected = YES;
    CLog(@"城市锦囊第%d项",sender.tag);
//    _tableView.hidden = YES ;
    
}


- (void)dataReceived:(id)sender obj:(NSObject *)obj
{
    //将网络访问对象置空
    //停止等待中的动画
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //停止加载更多的动画
    //停止下拉刷新动画
    if (_reloading) {
//       其他操作
    }
}

#pragma mark - UITableViewDelegate / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger  count = 0 ;
    
    if ([_listArray count]>0) {
    
        count = _listArray.count/3 ;
        if ([_listArray count] % 3 != 0) {
            count ++ ;
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"FocusCity";
    CityTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[CityTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.viewController = self ;
        cell.delegate = self;
    }
//    [cell loadCellData:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
    NSMutableArray * images = [[NSMutableArray alloc]init];
    for (int  i =  indexPath.row *3; i < indexPath.row *3 + 3; i ++) {
        if ([_listArray count] > i) {
            [images addObject:[_listArray objectAtIndex:i ]];
        }
        
        
    }
    [cell loadCityImages:images];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCityTopSpace + kCityHeight + kCityBottomSpace;
}

#pragma mark implment NextPageDelegate

-(void)goToNextPage:(UIButton *)sender
{
//    NSLog(@"具体的城市%d",sender.tag-50);
    TipsInfoViewController *tip = [[TipsInfoViewController alloc]init];
    
//    [self presentModalViewController:tip animated:YES];
    [self presentViewController:tip animated:YES completion:nil];
    
    
}

@end
