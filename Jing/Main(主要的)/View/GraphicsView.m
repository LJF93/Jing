
#import "GraphicsView.h"

@implementation GraphicsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();//获得当前画板

    //写字
    CGContextSetRGBStrokeColor(context, 0.2, 0.20, 0.2, 1.0f);//设置颜色
    CGContextSetLineWidth(context, 0.8f);//画线宽度
    UIFont *font = [UIFont systemFontOfSize:16.f];
    [@"开始写字" drawInRect:CGRectMake(10, 10, 100, 30) withAttributes:@{NSFontAttributeName:font}];

    //画笑脸弧线
    //左
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);//绘画路径
    //右
    CGContextMoveToPoint(context, 160, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
    CGContextStrokePath(context);//绘画路径

    /*画矩形*/
    CGContextStrokeRect(context,CGRectMake(240, 60, 10, 10));//画小方框
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);//填充颜色
    CGContextFillRect(context,CGRectMake(280, 60, 11, 11));//填充框

    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    UIColor *aColor = [UIColor blueColor];//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    aColor = [UIColor yellowColor];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(240, 80, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径

    [self circleAnimation];
    [self drawDottedLine];

    [super drawRect:rect];

}

#pragma mark - 使用贝塞尔曲线
/**
 画动画效果的圆
 */
- (void)circleAnimation {

    CAShapeLayer *layer = [CAShapeLayer layer];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 50, 60, 60) cornerRadius:30];
    layer.path = path.CGPath;
    layer.lineWidth=5;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor purpleColor].CGColor;
    [self.layer addSublayer:layer];

    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 5;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [layer addAnimation:checkAnimation forKey:nil];
}

/**
 画虚线
 */
- (void)drawDottedLine {

    CAShapeLayer *layer = [CAShapeLayer layer];

    UIBezierPath* aPath = [UIBezierPath bezierPath];
    //两点
    [aPath moveToPoint:CGPointMake(100, 20)];
    [aPath addLineToPoint:CGPointMake(200, 20)];
    layer.lineWidth = 1;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.path = aPath.CGPath;
    layer.lineDashPattern = @[@4,@2]; //3=线的宽度 1=每条线的间距
    [self.layer addSublayer:layer];
}

@end
