//
//  KnowledgeController.m
//  Jing
//
//  Created by Mac on 2017/5/19.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "KnowledgeController.h"
#import "Person.h"
#import "GraphicsView.h"
#import "Person+MutipleName.h"
#import <objc/runtime.h>

@interface KnowledgeController () <UIScrollViewDelegate> {
    dispatch_queue_t queue1;
    NSRunLoop *runloop;
    NSCondition *condition;

    Person *person;
    GraphicsView *graphicsView;

    NSInteger timeCount;

}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *animationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *runtimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KnowledgeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"知识点";

    [self contentView];

    [self startTimer];

    //    [self threadsManagement];

    person = [[Person alloc] init];
    person.chineseName = @"xiaoming";
    NSLog(@"Person first name is %@",person.chineseName);

}

- (void)viewDidDisappear:(BOOL)animated {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 运行，发现定时器还是没有停止。原因是Timer被添加到Runloop的时候，会被Runloop强引用了。

 然后 Timer 又会有一个对 Target 的强引用（也就是 self ）：

 也就是说 NSTimer 强引用了 self ，导致 self 一直不能被释放掉，所以也就走不到 self 的 dealloc 里。
 */
- (void)dealloc {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)contentView {
    graphicsView = [[GraphicsView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];

    //    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 240, self.view.bounds.size.width, 100)];
    //    textView.backgroundColor = [UIColor grayColor];
    //    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    //    textView.font = [UIFont systemFontOfSize:14];
    //    textView.editable = NO;
    //    textView.text = @"\r\n我的手机号不是： 13888888888 \r\n\r\n"
    //    "在线网址： www.baidu.com \r\n\r\n"
    //    "我的邮箱： worldliuxuejun@163.com \r\n\r\n";

    UIImage *myImage = [UIImage imageNamed:@"messi.png"];
    [self.myImageView setImage:[self imageCompressWithSimple:myImage scale:1.0]];

    // 模拟加载一组图片实现Gif动态图显示。
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 230, 60, 60)];
    gifImageView.animationImages = [self animationImages]; //获取Gif图片列表
    gifImageView.animationDuration = 0.3;     //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = INT_MAX;  //动画重复次数
    [gifImageView startAnimating];

    [self.scrollView addSubview:gifImageView];
    [self.scrollView addSubview:graphicsView];
    //    [scrollView addSubview:textView];
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    NSLog(@"\nkeyPath = %@, \nchange = %@, \ncontext = %s", keyPath, change, (char *)context);

}

#pragma mark - NSTimer
- (void)startTimer {

    // 方法1：
    // 在子线程中定义定时器：
    //    [NSThread detachNewThreadSelector:@selector(bannerStart) toTarget:self withObject:nil];

    // 方法2：
    timeCount = 0;
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    /*
     *如果我们把一个NSTimer对象以NSDefaultRunLoopMode（kCFRunLoopDefaultMode）添加到主运行循环中的时候, ScrollView滚动过程中会因为mode的切换，而导致NSTimer将不再被调度。

     若希望ScrollView滚动时，不调度定时器，那就应该使用NSDefaultRunLoopMode默认模式；
     
     若希望ScrollView滚动时，定时器也要回调，那就应该使用NSRunLoopCommonModes。
     */
}

- (void)bannerStart{
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (NSTimer *)countTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        //        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(actionTimer) userInfo:nil repeats:YES];
    }

    return _timer;
}

- (void)updateTimer {
    timeCount++;
    self.timeLabel.text = [NSString stringWithFormat:@"Timer: %ld",(long)timeCount];
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    NSLog(@"Timer:%ld",(long)timeCount);

}

#pragma mark - IBAction
- (IBAction)btnObserveAction:(id)sender {

    [person setValue:[NSNumber numberWithInteger:18] forKey:@"age"];
    [person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [person setValue:[NSNumber numberWithInteger:8] forKey:@"age"];

    //保存图片到本机相簿
    //    UIImageWriteToSavedPhotosAlbum(myImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

/**
 RunTime运行时机制（可以用来访问并修改一个类的私有属性）

 @param sender ...
 */
- (IBAction)runTimeBtnAction:(id)sender {
    unsigned int count = 0;
    // 获取类的所有属性变量
    Ivar *ivar = class_copyIvarList([person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];

        // 取得属性名并转成字符串类型
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];

        if ([name isEqualToString:@"chineseName"]) {
            // 修改属性值
            object_setIvar(person, var, @"Minggo");
            break;
        }
    }
    [self.runtimeBtn setTitle:person.chineseName forState:UIControlStateNormal];
    NSLog(@"Person second name is %@",person.chineseName);
}

- (IBAction)toSettingAction:(id)sender {
    //    NSURL *url = [NSURL URLWithString:@"Prefs:root=Privacy&path=LOCATION"];
    //    //    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];// iOS 10以后
    //    if ([[UIApplication sharedApplication] canOpenURL:url]) {
    //        NSDictionary *dic = [[NSDictionary alloc] init];
    //        [[UIApplication sharedApplication] openURL:url options:dic completionHandler:^(BOOL flag){
    //
    //        }];
    //    }

    NSURL *url=[NSURL URLWithString:@"Prefs:root=WIFI"];
    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:url withObject:nil];
}

- (void)defaultWorkspace{

}

- (BOOL)openSensitiveURL:(id)arg1 withOptions:(id)arg2{
    return YES;
}

- (UIImage *)imageCompressWithSimple:(UIImage *)image scale:(float)scale{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size); // this will crop
    [image drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

#pragma mark - 多线程
- (void)threadsManagement {
    // dispatch队列是线程安全的，可以利用串行队列实现锁的功能。比如多线程写同一数据库，需要保持写入的顺序和每次写入的完整性，简单地利用串行队列即可实现：
    // DISPATCH_QUEUE_SERIAL 生成一个串行队列，队列中的block按照先进先出（FIFO）的顺序去执行，实际上为单线程执行。
    queue1 = dispatch_queue_create("com.dispatch.writedb", DISPATCH_QUEUE_SERIAL);

    // 实际运用中，一般可以用dispatch这样来写常见的网络请求数据多线程执行模型：
    // 程序的后台运行和UI更新代码紧凑，代码逻辑一目了然。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程中开始网络请求数据
        //更新数据模型
        dispatch_sync(dispatch_get_main_queue(), ^{
            //在主线程中更新UI代码
        });
    });

    [self performSelectorInBackground:@selector(thread) withObject:nil]; //启动包含run loop的线程
}

/**
 下一次调用writeDB:必须等到上次调用完成后才能进行，保证writeDB:方法是线程安全的。

 @param data 写入数据库中的数据
 */
- (void)writeDB:(NSData *)data {
    dispatch_async(queue1, ^{
        // write database
    });
}

- (void)thread {
    runloop = [NSRunLoop currentRunLoop]; //设置为当前线程的run loop值
    while (condition) {
        [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]]; //启动run loop
    }
}

/**
 dispatch group实现并发多任务
 */
- (void)dispatchGroup {
    __block NSString *_str1, *_str2;

    dispatch_group_t group = dispatch_group_create();// 全局变量group
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);// 并行队列

    // 进入组（进入组和离开组必须成对出现,否则会造成死锁）
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        // 执行异步任务1
        [NSThread sleepForTimeInterval:2];
        for (int i = 0; i < 3; i ++) {
            NSLog(@"%d---%@", i, [NSThread currentThread ]);    //子线程
        }
        _str1 = @"str1";
        dispatch_group_leave(group);
    });

    // 进入组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        // 执行异步任务2
        [NSThread sleepForTimeInterval:2];
        for (int i = 3; i < 6; i ++) {
            NSLog(@"%d---%@", i, [NSThread currentThread ]);
        }
        _str2 = @"str2";
        dispatch_group_leave(group);
    });

    //使用dispatch_group_enter(group)和dispatch_group_leave(group)是为了确保每个任务的完成，即使某个任务是异步的，在所有任务都完成后再执行notify中的代码。
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        NSLog(@"_str1:%@\n_str2:%@",_str1, _str2);
        NSLog(@"%@", [NSThread currentThread]); //主线程
        NSLog(@"完成...");
    });
}

- (void)sessionUpload {
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSData *data = [[NSData alloc] init];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:data
                                                      completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // ...
                                          }];

    [uploadTask resume];
}

- (void)sessionDownload {
    NSURL *URL = [NSURL URLWithString:@"http://example.com/file.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                                                                NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
                                                                [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
                                                            }];

    [downloadTask resume];
}

- (void)sessionGet {
    //第一种方式创建session，单例，获取全局session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建url对象
    NSString *urlStr = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20151031&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    //得到网址
    NSURL *url = [NSURL URLWithString:urlStr];

    //建立请求任务.block方式，通过url建立task，不需要建立request
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            //解析数据
                                            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                            NSLog(@"%@",str);
                                        }];


    //    //第二种方式创建session，可以给session设置工作模式
    //        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //    //如果需要设置缓存策略、请求超时等,需要创建请求对象request
    //    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url
    //                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
    //                                         timeoutInterval:30];
    //
    //    //通过request方式建立任务
    //    NSURLSessionTask *task = [session dataTaskWithRequest:req
    //                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //                                            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //                                            NSLog(@"%@",str);
    //                                        }];
    //启动任务
    [task resume];
}

#pragma mark - CAAnimation
- (IBAction)animationAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    CGPoint point = [btn.superview convertPoint:btn.center toView:self.view];

    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(-20, -20, 20, 20)];
    view.image = [UIImage imageNamed:@"cart-product.png"];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x+20, point.y);//起始点的坐标
    CGPathAddQuadCurveToPoint(path, NULL, 160, 30, Main_Screen_Width-30, 44);
    animation.path = path;
    animation.duration = 0.8;
    [view.layer addAnimation:animation forKey:@"move"];

}

- (NSArray *)animationImages {
    NSFileManager *fielM = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"];
    NSArray *arrays = [fielM contentsOfDirectoryAtPath:path error:nil];

    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSString *name in arrays) {
        UIImage *image = [UIImage imageNamed:[(@"Loading.bundle") stringByAppendingPathComponent:name]];
        //        UIImage *animatedImage = [UIImage animatedImageWithImages:arrays duration:0.8];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    return imagesArr;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"Current RunLoop Mode is %@\n", [[NSRunLoop currentRunLoop] currentMode]);
}

@end
