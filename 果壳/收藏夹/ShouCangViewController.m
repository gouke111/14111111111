//
//  ShouCangViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/24.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ShouCangViewController.h"
#import "ChildViewController.h"
#import "ShouViewController.h"
#import "ZanViewController.h"
@interface ShouCangViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UISegmentedControl*titleSegment;


@property(nonatomic,strong)UIView*greenview;
@property(nonatomic,strong)UIScrollView*scroll;

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleSegment=[[UISegmentedControl alloc]initWithItems:@[@"收藏的",@"赞过的",@"评论过的"]];
    _titleSegment.frame=CGRectMake(0, 60, ScreenWidth, 28);
    _titleSegment.backgroundColor=[UIColor whiteColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName: [UIColor greenColor]};
    [_titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor grayColor]};
    _titleSegment.tintColor=[UIColor clearColor];
    [_titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [_titleSegment addTarget:self action:@selector(segmentmath) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_titleSegment];

    //小条
    //uiview 动画
    _greenview=[[UIView alloc]initWithFrame:CGRectMake(0, 88, ScreenWidth/3.0, 2)];
    _greenview.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_greenview];
    //_scroll
    
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 90, ScreenWidth,ScreenHeight-90)];
    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addchildVC];
    
    _scroll.contentSize=CGSizeMake(self.childViewControllers.count * ScreenWidth,ScreenHeight-90);
    _scroll.pagingEnabled=YES;
    _scroll.bounces=NO;
    _scroll.showsVerticalScrollIndicator=NO;
    _scroll.showsHorizontalScrollIndicator=NO;
    
    // Do any additional setup after loading the view.
    
    //tableViews
    _scroll.delegate=self;
    [self.view addSubview:_scroll];
    [self scrollViewDidEndDecelerating:_scroll];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Titlesegment调用方法
-(void)segmentmath{
    [self animotion];
        _scroll.contentOffset=CGPointMake(ScreenWidth*_titleSegment.selectedSegmentIndex, 0);
    [self scrollViewDidEndScrollingAnimation:_scroll];
    
}
-(void)addchildVC{
    ShouViewController*shoucang=[[ShouViewController alloc]init];
    shoucang.url=[NSString stringWithFormat: @"http://apis.guokr.com/handpick/collect.json?detail=true&retrieve_type=by_timeline&access_token=%@&until=%@&limit=20",_access_token,[self GETTime]];
    [self addChildViewController:shoucang];
    ZanViewController*zan=[[ZanViewController alloc]init];
    zan.url=[NSString stringWithFormat: @"http://apis.guokr.com/handpick/article_liking.json?access_token=%@&limit=20",_access_token];
    [self addChildViewController:zan];
    ChildViewController*pinglun=[[ChildViewController alloc]init];
    pinglun.url=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/v2/article.json?retrieve_type=by_ukey_reply&access_token=%@&until=%@&limit=20",_access_token,[self GETTime]];
    [self addChildViewController:pinglun];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self. childViewControllers[index];
    
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    int index = _scroll.contentOffset.x / _scroll.width;
    _titleSegment.selectedSegmentIndex=index;
    [self segmentmath];
    
}

//uiview动画
-(void)animotion{
    [UIView beginAnimations:@"1" context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationRepeatAutoreverses:NO];
    _greenview.center=CGPointMake(ScreenWidth/3.0*_titleSegment.selectedSegmentIndex+ScreenWidth/6.0, _greenview.center.y) ;
    [UIView commitAnimations];
}

-(NSString*)GETTime{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d", (int)a];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
