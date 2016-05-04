//
//  LCLikeButton.m
//  LCLikeButton
//
//  Created by bawn on 4/8/16.
//  Copyright © 2016 bawn. All rights reserved.
//

#import "LCLikeButton.h"
#import <Masonry.h>
#import <QuartzCore/QuartzCore.h>


//static CGFloat kLCVelocityRange = 0;
//static CGFloat kLCVelocity = 1;
//static float kLCLifetimeRange = 0.0;
//static float kLCLifetime = 0.4;
//static float kLCBirthRate = 1;

@interface LCLikeButton ()

@property (nonatomic, strong) UIImageView *heartImageView;
@property (nonatomic, strong) UIImageView *loveImageView;
@property (nonatomic, strong) UIView *roundView;
@property (nonatomic, strong) UIImageView *circlesImageView;
@property (nonatomic, strong) NSMutableArray <UIImageView *> *particleImageViews;

//@property (nonatomic, strong) UIImageView *redParticle;
//@property (nonatomic, strong) UIImageView *cyanParticle;
//@property (nonatomic, strong) UIImageView *chartreuseParticle;
//@property (nonatomic, strong) UIImageView *raquamarineParticle;
//@property (nonatomic, strong) UIImageView *navajowhiteParticle;
//@property (nonatomic, strong) UIImageView *midnightblueParticle;
//@property (nonatomic, strong) UIImageView *aquamarineParticle;
//@property (nonatomic, strong) UIImageView *goldParticle;
//@property (nonatomic, strong) UIImageView *lightgreenParticle;


@end

@implementation LCLikeButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
    }];
    
    
    NSArray <NSString *>*imageNameArray = @[
                                            @"icon_particle_red",
                                            @"icon_particle_cyan",
                                            @"icon_particle_chartreuse",
                                            @"icon_particle_raquamarine",
                                            @"icon_particle_navajowhite",
                                            @"icon_particle_midnightblue",
                                            @"icon_particle_midnightblue",
                                            @"icon_particle_aquamarine",
                                            @"icon_particle_gold",
                                            @"icon_particle_lightgreen",
                                            ];
    self.particleImageViews = [[NSMutableArray alloc] initWithCapacity:imageNameArray.count];
    [imageNameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addParticleImageView:obj];
    }];
    
    self.roundView = [[UIView alloc] init];
    self.roundView.userInteractionEnabled = NO;
    self.roundView.backgroundColor = [UIColor colorWithRed:0.95 green:0.69 blue:0.67 alpha:1.00];
    self.roundView.layer.cornerRadius = 5.0f;
    [self addSubview:self.roundView];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];


    self.circlesImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circles"]];
    [self addSubview:self.circlesImageView];
    [self.circlesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.circlesImageView.transform = CGAffineTransformMakeScale(0.08, 0.08);
    
    
    UIImage *loveImage = [UIImage imageNamed:@"heart_after"];
    self.loveImageView = [[UIImageView alloc] initWithImage:loveImage];
    [self addSubview:self.loveImageView];
    [self.loveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(4);
    }];
    self.loveImageView.alpha = 0.0f;
    
    
    UIImage *heartImage = [UIImage imageNamed:@"heart_before"];
    self.heartImageView = [[UIImageView alloc] initWithImage:heartImage];
    [self addSubview:self.heartImageView];
    [self.heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.heartImageView.transform = CGAffineTransformMakeScale(0.76, 0.76);
}


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected == YES) {
        [self showAnimation];
    }
    else{
        [self stopAnimation];
        self.heartImageView.alpha = 1;
        self.loveImageView.alpha = 0;
    }
}

- (void)stopAnimation{
    [self.heartImageView.layer removeAllAnimations];
    [self.loveImageView.layer removeAllAnimations];
    [self.roundView.layer removeAllAnimations];
    [self.circlesImageView.layer removeAllAnimations];
    [self.particleImageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer removeAllAnimations];
    }];
}


//- (void)showAnimation{
//    [self configAnimation];
//    
//}

- (void)showAnimation{
    [self stopAnimation];
    CABasicAnimation *heartScalOneAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    heartScalOneAnimation.fromValue = @0.76;
    heartScalOneAnimation.toValue = @1.0;
    heartScalOneAnimation.duration = 0.12;
    heartScalOneAnimation.removedOnCompletion = NO;
    heartScalOneAnimation.fillMode = kCAFillModeForwards;
    heartScalOneAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *heartScalTwoAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    heartScalTwoAnimation.fromValue = @1.0;
    heartScalTwoAnimation.toValue = @0.76;
    heartScalTwoAnimation.duration = 0.12;
    heartScalTwoAnimation.beginTime = 0.15;
    heartScalTwoAnimation.removedOnCompletion = NO;
    heartScalTwoAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *heartFadeTwoAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    heartFadeTwoAnimation.fromValue = @1.0;
    heartFadeTwoAnimation.toValue = @0.0;
    heartFadeTwoAnimation.duration = 0.03;
    heartFadeTwoAnimation.beginTime = 0.3;
    heartFadeTwoAnimation.removedOnCompletion = NO;
    heartFadeTwoAnimation.fillMode = kCAFillModeForwards;

    CAAnimationGroup *heartGroup = [CAAnimationGroup animation];
    heartGroup.animations = @[heartScalOneAnimation, heartScalTwoAnimation, heartFadeTwoAnimation];
    heartGroup.duration = 0.33;
    heartGroup.removedOnCompletion = NO;
    heartGroup.fillMode = kCAFillModeForwards;
    heartGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.heartImageView.layer addAnimation:heartGroup forKey:@"heart"];

    
    
    CABasicAnimation *roundScalAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    roundScalAnimation.fromValue = @1.0;
    roundScalAnimation.toValue = @10.0;
    roundScalAnimation.duration = 0.6;
    roundScalAnimation.removedOnCompletion = NO;
    roundScalAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *roundFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    roundFadeAnimation.fromValue = @1.0;
    roundFadeAnimation.toValue = @0.0;
    roundFadeAnimation.duration = 0.33;
    roundFadeAnimation.beginTime = 0.27;
    roundFadeAnimation.removedOnCompletion = NO;
    roundFadeAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *roundGroup = [CAAnimationGroup animation];
    roundGroup.animations = @[roundScalAnimation, roundFadeAnimation];
    roundGroup.duration = 0.6;
    roundGroup.removedOnCompletion = NO;
    roundGroup.fillMode = kCAFillModeForwards;
    roundGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.roundView.layer addAnimation:roundGroup forKey:@"round"];
    
    CABasicAnimation *circlesScalAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circlesScalAnimation.fromValue = @0.08;
    circlesScalAnimation.toValue = @1.0;
    circlesScalAnimation.duration = 0.6;
    circlesScalAnimation.removedOnCompletion = NO;
    circlesScalAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *circlesFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    circlesFadeAnimation.fromValue = @1.0;
    circlesFadeAnimation.toValue = @0.0;
    circlesFadeAnimation.duration = 0.33;
    circlesFadeAnimation.beginTime = 0.27;
    circlesFadeAnimation.removedOnCompletion = NO;
    circlesFadeAnimation.fillMode = kCAFillModeForwards;

    CAAnimationGroup *circlesGroup = [CAAnimationGroup animation];
    circlesGroup.animations = @[circlesScalAnimation, circlesFadeAnimation];
    circlesGroup.duration = 0.6;
    circlesGroup.removedOnCompletion = NO;
    circlesGroup.fillMode = kCAFillModeForwards;
    circlesGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    circlesGroup.delegate = self;
    [self.circlesImageView.layer addAnimation:circlesGroup forKey:@"circles"];
    

    CABasicAnimation *loveFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    loveFadeAnimation.fromValue = @0.0;
    loveFadeAnimation.toValue = @1.0;
    loveFadeAnimation.duration = 0.33;
    loveFadeAnimation.beginTime = CACurrentMediaTime() + 0.24;
    loveFadeAnimation.removedOnCompletion = NO;
    loveFadeAnimation.fillMode = kCAFillModeForwards;
    loveFadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.loveImageView.layer addAnimation:loveFadeAnimation forKey:@"love"];
    
    [self addAnimation:self.particleImageViews[0] withByValue:CGPointMake(0, 34.0f) delay:0.14];
    [self addAnimation:self.particleImageViews[1] withByValue:CGPointMake(-32.0f, 2.0f) delay:0.06];
    [self addAnimation:self.particleImageViews[2] withByValue:CGPointMake(-18.0f, -26.0f) delay:0.1];
    [self addAnimation:self.particleImageViews[3] withByValue:CGPointMake(0.0f, -29.0f) delay:0.06];
    [self addAnimation:self.particleImageViews[4] withByValue:CGPointMake(-27.0f, -16.0f) delay:0.2];
    [self addAnimation:self.particleImageViews[5] withByValue:CGPointMake(24.0f, 21.0f) delay:0.1];
    [self addAnimation:self.particleImageViews[6] withByValue:CGPointMake(28.0f, -14.0f) delay:0.14];
    [self addAnimation:self.particleImageViews[7] withByValue:CGPointMake(3.0f, 19.0f) delay:0.04];
    [self addAnimation:self.particleImageViews[8] withByValue:CGPointMake(-25.0f, 18.0f) delay:0.1];
    [self addAnimation:self.particleImageViews[9] withByValue:CGPointMake(12.0f, -18.0f) delay:0.1];
}


- (void)addParticleImageView:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.particleImageViews addObject:imageView];
}

- (void)addAnimation:(UIView *)target withByValue:(CGPoint)point delay:(NSTimeInterval)delay{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.byValue = [NSValue valueWithCGPoint:point];
    moveAnimation.duration = 0.6;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @1;
    fadeAnimation.toValue = @0;
    fadeAnimation.duration = 0.3;
    fadeAnimation.beginTime = 0.3;
    fadeAnimation.removedOnCompletion = NO;
    fadeAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveAnimation, fadeAnimation];
    group.duration = 0.6;
    group.beginTime = CACurrentMediaTime() + delay;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [target.layer addAnimation:group forKey:target.description];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%s", __func__);
}

//- (void)configEmitter{
//    for (CALayer *layer in self.layer.sublayers) {
//        if (layer.class == [CAEmitterLayer class]) {
//            [layer removeFromSuperlayer];
//        }
//    }
//    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
//    [self.contentView.layer addSublayer:emitterLayer];
//    emitterLayer.name = @"CAEmitterLayer";
//    emitterLayer.emitterShape = kCAEmitterLayerCircle;
//    emitterLayer.emitterMode = kCAEmitterLayerOutline;
//    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
//    emitterLayer.spin = 1;
//    emitterLayer.emitterSize = (CGSize){16.0f, 16.0f};
//    emitterLayer.position = (CGPoint){self.frame.size.width * 0.5f, self.frame.size.width * 0.5f};
//    emitterLayer.masksToBounds = NO;
////    emitterLayer.seed = 31233;
////    emitterLayer.birthRate = 1;
////    emitterLayer.speed = 80;
//    emitterLayer.velocity = 60;
//    
//    CABasicAnimation *velocityAnimation = [CABasicAnimation animationWithKeyPath:@"velocity"];
//    velocityAnimation.fromValue = @60.0;
//    velocityAnimation.toValue = @60.0;
//    velocityAnimation.duration = 0.4;
//    velocityAnimation.removedOnCompletion = NO;
//    velocityAnimation.fillMode = kCAFillModeForwards;
//    velocityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [emitterLayer addAnimation:velocityAnimation forKey:@"emitterLayer"];
//    
//    
//    CAEmitterCell *redCell = [CAEmitterCell emitterCell];
//    redCell.name = @"red";
//    redCell.alphaRange = 1;
//    redCell.emissionRange = M_PI * 2.0;
//
//    redCell.lifetime = kLCLifetime;
//    redCell.lifetimeRange = 0.1;
//    redCell.velocity = kLCVelocity;
//    redCell.velocityRange = kLCVelocityRange;
//    redCell.alphaSpeed = -1.0/kLCLifetime;
//    redCell.scale = 0.5;
//    redCell.birthRate = kLCBirthRate;
//    redCell.contents = (id)[[UIImage imageNamed:@"icon_particle_red"] CGImage];
//    
//    
//    
//    CAEmitterCell *cyanCell = [CAEmitterCell emitterCell];
//    cyanCell.name = @"cyan";
//    cyanCell.emissionRange = M_PI;
//    cyanCell.alphaRange = 1;
//    cyanCell.lifetime = kLCLifetime;
//    cyanCell.lifetimeRange = kLCLifetimeRange;
//    cyanCell.velocity = kLCVelocity;
//    cyanCell.velocityRange = kLCVelocityRange;
//    cyanCell.alphaSpeed = -1.0/kLCLifetime;
//    cyanCell.scale = 0.5;
//    cyanCell.birthRate = kLCBirthRate;
//    
//    cyanCell.contents = (id)[[UIImage imageNamed:@"icon_particle_cyan"] CGImage];
//    
//    
//    CAEmitterCell *chartreuseCell = [CAEmitterCell emitterCell];
//    chartreuseCell.name = @"chartreuse";
//    chartreuseCell.emissionRange = M_PI_2;
//    chartreuseCell.alphaRange = 1;
//    chartreuseCell.lifetime = kLCLifetime;
//    chartreuseCell.lifetimeRange = kLCLifetimeRange;
//    chartreuseCell.velocity = kLCVelocity;
//    chartreuseCell.velocityRange = kLCVelocityRange;
//    chartreuseCell.alphaSpeed = -1.0/kLCLifetime;
//    chartreuseCell.scale = 0.5;
//    chartreuseCell.birthRate = kLCBirthRate;
//    
//    chartreuseCell.contents = (id)[[UIImage imageNamed:@"icon_particle_chartreuse"] CGImage];
//    
//    
//    CAEmitterCell *aquamarineCell = [CAEmitterCell emitterCell];
//    aquamarineCell.name = @"aquamarine";
//    aquamarineCell.alphaRange = 1;
//    aquamarineCell.emissionRange = M_PI_4;
//    aquamarineCell.lifetime = kLCLifetime;
//    aquamarineCell.lifetimeRange = kLCLifetimeRange;
//    aquamarineCell.velocity = kLCVelocity;
//    aquamarineCell.velocityRange = kLCVelocityRange;
//    aquamarineCell.alphaSpeed = -1.0/kLCLifetime;
//    aquamarineCell.scale = 0.5;
//    aquamarineCell.birthRate = kLCBirthRate;
//    
//    aquamarineCell.contents = (id)[[UIImage imageNamed:@"icon_particle_aquamarine"] CGImage];
//    
//    
//
//    CAEmitterCell *blueCell = [CAEmitterCell emitterCell];
//    blueCell.name = @"blue";
//    blueCell.alphaRange = 1;
//    
//    blueCell.lifetime = kLCLifetime;
//    blueCell.lifetimeRange = kLCLifetimeRange;
//    blueCell.velocity = kLCVelocity;
//    blueCell.velocityRange = kLCVelocityRange;
//    blueCell.alphaSpeed = -1.0/kLCLifetime;
//    blueCell.scale = 0.5;
//    blueCell.birthRate = kLCBirthRate;
//    
//    blueCell.contents = (id)[[UIImage imageNamed:@"icon_particle_blue"] CGImage];
//    
//    
//    CAEmitterCell *goldCell = [CAEmitterCell emitterCell];
//    goldCell.name = @"gold";
//    goldCell.alphaRange = 1;
//    goldCell.lifetime = kLCLifetime;
//    goldCell.lifetimeRange = kLCLifetimeRange;
//    goldCell.velocity = kLCVelocity;
//    goldCell.velocityRange = kLCVelocityRange;
//    goldCell.alphaSpeed = -1.0/kLCLifetime;
//    goldCell.scale = 0.5;
//    goldCell.birthRate = kLCBirthRate;
//    
//    goldCell.contents = (id)[[UIImage imageNamed:@"icon_particle_gold"] CGImage];
//    
//    
//    
//    CAEmitterCell *lightgreenCell = [CAEmitterCell emitterCell];
//    lightgreenCell.name = @"lightgreen";
//    lightgreenCell.alphaRange = 1;
//    lightgreenCell.lifetime = kLCLifetime;
//    lightgreenCell.lifetimeRange = kLCLifetimeRange;
//    lightgreenCell.velocity = kLCVelocity;
//    lightgreenCell.velocityRange = kLCVelocityRange;
//    lightgreenCell.alphaSpeed = -1.0/kLCLifetime;
//    lightgreenCell.scale = 0.5;
//    lightgreenCell.birthRate = kLCBirthRate;
//    lightgreenCell.contents = (id)[[UIImage imageNamed:@"icon_particle_lightgreen"] CGImage];
//    
//    
//    CAEmitterCell *midnightblueCell = [CAEmitterCell emitterCell];
//    midnightblueCell.name = @"midnightblue";
//    midnightblueCell.alphaRange = 1;
//    midnightblueCell.lifetime = kLCLifetime;
//    midnightblueCell.lifetimeRange = kLCLifetimeRange;
//    midnightblueCell.velocity = kLCVelocity;
//    midnightblueCell.velocityRange = kLCVelocityRange;
//    midnightblueCell.alphaSpeed = -1.0/kLCLifetime;
//    midnightblueCell.scale = 0.5;
//    midnightblueCell.birthRate = kLCBirthRate;
//    midnightblueCell.contents = (id)[[UIImage imageNamed:@"icon_particle_midnightblue"] CGImage];
//    
//    
//    CAEmitterCell *navajowhiteCell = [CAEmitterCell emitterCell];
//    navajowhiteCell.name = @"navajowhite";
//    navajowhiteCell.alphaRange = 1;
//    navajowhiteCell.lifetime = kLCLifetime;
//    navajowhiteCell.lifetimeRange = kLCLifetimeRange;
//    navajowhiteCell.velocity = kLCVelocity;
//    navajowhiteCell.velocityRange = kLCVelocityRange;
//    navajowhiteCell.alphaSpeed = -1.0/kLCLifetime;
//    navajowhiteCell.scale = 0.5;
//    navajowhiteCell.birthRate = kLCBirthRate;
//    navajowhiteCell.contents = (id)[[UIImage imageNamed:@"icon_particle_navajowhite"] CGImage];
//
//
//    
//    emitterLayer.emitterCells = @[redCell, cyanCell, chartreuseCell, lightgreenCell, goldCell, blueCell, aquamarineCell, midnightblueCell, navajowhiteCell];
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.red.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.cyan.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.chartreuse.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.aquamarine.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.blue.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.gold.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.lightgreen.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.midnightblue.birthRate"];
//        [emitterLayer setValue:@0 forKeyPath:@"emitterCells.navajowhite.birthRate"];
//    });
//}


//-(void) stopEmission {
//    [emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitter1.birthRate"];
//    [emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitter2.birthRate"];
//}

@end
