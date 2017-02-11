//
//  HomeViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "HomeViewController.h"
#import "AllViewController.h"
#import "SuperViewController.h"

#import "SearchViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>
    
@property(nonatomic,strong)UIScrollView*titleScroll;
@property(nonatomic,strong)UISegmentedControl*titleSegment;


@property(nonatomic,strong)UIView*greenview;
@property(nonatomic,strong)UIScrollView*scroll;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem*search=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem=search;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor greenColor];
    UIBarButtonItem*Left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉"] style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    
    self.navigationItem.leftBarButtonItem=Left;
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"果壳精选";
    self.automaticallyAdjustsScrollViewInsets=NO;
    _titleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,60, ScreenWidth, 30)];
    _titleScroll.contentSize=CGSizeMake(ScreenWidth/5.0*8, 30);
    _titleScroll.backgroundColor=[UIColor whiteColor];
    
    _titleScroll.bounces=NO;
    _titleScroll.showsVerticalScrollIndicator=NO;
    _titleScroll.showsHorizontalScrollIndicator=NO;
    _titleScroll.directionalLockEnabled=YES;
    _titleSegment=[[UISegmentedControl alloc]initWithItems:@[@"全部",@"科技",@"生活",@"健康",@"学习",@"人文",@"自然",@"娱乐"]];
    _titleSegment.frame=CGRectMake(0, 0, ScreenWidth/5.0*8, 28);
    _titleSegment.backgroundColor=[UIColor whiteColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName: [UIColor greenColor]};
    [_titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor grayColor]};
    _titleSegment.tintColor=[UIColor clearColor];
    [_titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [_titleSegment addTarget:self action:@selector(segmentmath) forControlEvents:UIControlEventValueChanged];
    [_titleScroll addSubview:_titleSegment];
    [self.view addSubview:_titleScroll];
    //小条
    //uiview 动画
    _greenview=[[UIView alloc]initWithFrame:CGRectMake(0, 28, ScreenWidth/5.0, 2)];
    _greenview.backgroundColor=[UIColor greenColor];
    [_titleScroll addSubview:_greenview];
    //_scroll
    
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 90, ScreenWidth,ScreenHeight-90)];
    // 不要自动调整scrollView的contentInset
    //self.automaticallyAdjustsScrollViewInsets = NO;
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SignUpAnnimation) name:@"zancell" object:nil];
    
}
-(void)SignUpAnnimation{
        SignupViewController*signvc=[[SignupViewController alloc]init];
        [self showViewController:signvc sender:nil];
        UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        label.backgroundColor=[UIColor lightGrayColor];
        label.layer.cornerRadius=10;
        label.layer.masksToBounds=YES;
        label.text = @"请先登录";
        label.textColor=[UIColor lightTextColor];
        [label sizeToFit];
        label.width+=20;
        label.height+=10;
        label.textAlignment=NSTextAlignmentCenter;
        label.center=signvc.view.center;
        [signvc.view addSubview:label];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:3.0];
        label.alpha = 0.0;
        [UIView commitAnimations];
    }

//Titlesegment调用方法
-(void)segmentmath{
    [self animotion];
    if (_titleSegment.selectedSegmentIndex>2&&_titleSegment.selectedSegmentIndex<5) {
        _titleScroll.contentOffset=CGPointMake(ScreenWidth/5.0*(_titleSegment.selectedSegmentIndex)+ScreenWidth/10.0-ScreenWidth/2.0, 0);
    }else if (_titleSegment.selectedSegmentIndex<=2){
        _titleScroll.contentOffset=CGPointMake(0, 0);
       
    }else{
        _titleScroll.contentOffset=CGPointMake(ScreenWidth/5.0*3, 0);
    }
    _scroll.contentOffset=CGPointMake(ScreenWidth*_titleSegment.selectedSegmentIndex, 0);
    [self scrollViewDidEndScrollingAnimation:_scroll];
    
}
-(void)addchildVC{
    NSArray*fenlei=@[@"science",@"life",@"health",@"learning",@"humanities",@"nature",@"entertainment"];
    AllViewController*all=[[AllViewController alloc]init];
    [self addChildViewController:all];
    SuperViewController*kexue=[[SuperViewController alloc]init];
    kexue.category=fenlei[0];
    [self addChildViewController:kexue];
    SuperViewController*life=[[SuperViewController alloc]init];
    life.category=fenlei[1];
    [self  addChildViewController:life];
    SuperViewController*health=[[SuperViewController alloc]init];
    health.category=fenlei[2];
    [self  addChildViewController:health];
    SuperViewController*learning=[[SuperViewController alloc]init];
    learning.category=fenlei[3];
    [self addChildViewController:learning];
    SuperViewController*humanities=[[SuperViewController alloc]init];
    humanities.category=fenlei[4];
    [self addChildViewController:humanities];
    SuperViewController*nature=[[SuperViewController alloc]init];
    nature.category=fenlei[5];
    [self addChildViewController:nature];
    SuperViewController*entertainment=[[SuperViewController alloc]init];
    entertainment.category=fenlei[6];
    [self addChildViewController:entertainment];
    
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
    _greenview.center=CGPointMake(ScreenWidth/5.0*_titleSegment.selectedSegmentIndex+ScreenWidth/10.0, _greenview.center.y) ;
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----left
-(void)left{
    [self.sideMenuViewController presentLeftMenuViewController];
    
}
//search-----
-(void)search{
    SearchViewController*search=[[SearchViewController alloc]init];
    self.navigationItem.backBarButtonItem.title=@"返回";
    [self.navigationController showViewController:search sender:nil];
}

//-----------
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
