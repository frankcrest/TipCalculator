//
//  ViewController.m
//  TipCalculator
//
//  Created by Frank Chen on 2019-05-10.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) float billAmount;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (nonatomic,strong) NSNotificationCenter* notificationCenter;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (nonatomic, assign) float tipPercentage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self.notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(NSNotificationCenter *)notificationCenter{
    return [NSNotificationCenter defaultCenter];
}

- (IBAction)calculateTipButtonPressed:(id)sender {
    float totalAmount = [self.myTextField.text floatValue];
    NSString* tipAmount = [NSString stringWithFormat:@"$%0.2f",[self calculateTip:totalAmount]];
    self.tipLabel.text = tipAmount;
}

-(float)calculateTip:(float)total{
    if (![self.tipPercentageTextField.text isEqualToString:@""]) {
        NSLog(@"textfield");
        self.tipPercentage = [self.tipPercentageTextField.text floatValue] / 100;
    } else if (self.tipSlider.value){
        NSLog(@"slider");
        self.tipPercentage = self.tipSlider.value / 100;
    } else{
        NSLog(@"default");
        self.tipPercentage = 0.15;
    }

    [self.myTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
    
    return total * self.tipPercentage;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    self.containerView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
}

- (void)keyboardDidHide:(NSNotification *)notification{
    NSLog(@"hide");
    //self.containerView.center = CGPointMake(self.view.center.x, self.view.center.y);
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentage = sender.value;
}

- (void) dealloc{
    [self.notificationCenter removeObserver:self];
}


@end

