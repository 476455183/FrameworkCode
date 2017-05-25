//
//  AnimationViewController.m
//  GZMoFrameworkDemo
//
//  Created by mojx on 16/8/30.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tapButton:(id)sender
{
    UIButton *button = sender;
    AnimationType animationType = button.tag;
    
    NSString *subtypeString;
    
    switch (subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    subtype += 1;
    if (subtype > 3) {
        subtype = 0;
    }
    
    switch (animationType) {
        case Fade:
            [MoCATransition transitionWithType:kCATransitionFade withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case Push:
            [MoCATransition transitionWithType:kCATransitionPush withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case Reveal:
            [MoCATransition transitionWithType:kCATransitionReveal withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case MoveIn:
            [MoCATransition transitionWithType:kCATransitionMoveIn withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case Cube:
            [MoCATransition transitionWithType:@"cube" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case SuckEffect:
            [MoCATransition transitionWithType:@"suckEffect" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case OglFlip:
            [MoCATransition transitionWithType:@"oglFlip" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case RippleEffect:
            [MoCATransition transitionWithType:@"rippleEffect" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case PageCurl:
            [MoCATransition transitionWithType:@"pageCurl" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case PageUnCurl:
            [MoCATransition transitionWithType:@"pageUnCurl" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case CameraIrisHollowOpen:
            [MoCATransition transitionWithType:@"cameraIrisHollowOpen" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case CameraIrisHollowClose:
            [MoCATransition transitionWithType:@"cameraIrisHollowClose" withSubtype:subtypeString forView:self.view duration:0.7];
            break;
            
        case CurlDown:
            [MoCATransition animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlDown duration:0.7];
            break;
            
        case CurlUp:
            [MoCATransition animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlUp duration:0.7];
            break;
            
        case FlipFromLeft:
            [MoCATransition animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromLeft duration:0.7];
            break;
            
        case FlipFromRight:
            [MoCATransition animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromRight duration:0.7];
            break;
            
        default:
            break;
    }
    
    static int i = 0;
    if (i == 0)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"02.jpg"]];
        i = 1;
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"01.jpg"]];
        i = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
