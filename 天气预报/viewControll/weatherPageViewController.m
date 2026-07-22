//
//  weatherPageViewController.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/21.
//

#import "weatherPageViewController.h"
#import <Masonry/Masonry.h>
@interface weatherPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource,UIScrollViewDelegate>

@property(nonatomic, strong) UIPageControl* pageControll;

@end

@implementation weatherPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*) view;
            scrollView.delegate = self;
        }
    }
    self.view.backgroundColor = [UIColor clearColor];
    UIButton *button = [UIButton buttonWithConfiguration:[UIButtonConfiguration clearGlassButtonConfiguration] primaryAction:nil];
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:16 weight:UIImageSymbolWeightBold];
    UIImage *image = [[UIImage systemImageNamed:@"line.3.horizontal"] imageByApplyingSymbolConfiguration:config];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view).offset(-40);
        make.height.width.mas_equalTo(50);
    }];
    UIButton* backgroundButton = [UIButton buttonWithConfiguration:[UIButtonConfiguration clearGlassButtonConfiguration] primaryAction:nil];
    [self.view addSubview: backgroundButton];
    [backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.bottom.equalTo(button);
    }];
    self.pageControll = [[UIPageControl alloc] init];
    self.pageControll.backgroundColor = [UIColor clearColor];
    self.pageControll.numberOfPages = self.controllersArray.count;
    self.pageControll.currentPage = self.currentIndex;
    self.pageControll.userInteractionEnabled = NO;
    self.pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    [backgroundButton addSubview:self.pageControll];
    [self.pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backgroundButton);
        make.left.equalTo(backgroundButton).offset(10);
        make.right.equalTo(backgroundButton).offset(-10);
    }];
    [self setViewControllers:@[self.controllersArray[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllersArray indexOfObject:viewController];
    index++;
    if (index >= self.controllersArray.count) {
        return nil;
    }
    return self.controllersArray[index];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllersArray indexOfObject:viewController];
    index--;
    if (index < 0) {
        return nil;
    }
    return self.controllersArray[index];
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        return;
    }
    UIViewController *currentVC = self.viewControllers.firstObject;
    NSInteger index = [self.controllersArray indexOfObject:currentVC];
    self.currentIndex = index;
    self.pageControll.currentPage = index;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat width = scrollView.bounds.size.width;
    if (self.currentIndex == 0 && scrollView.contentOffset.x < width * 0.8) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
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
