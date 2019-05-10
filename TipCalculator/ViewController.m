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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)calculateTipButtonPressed:(id)sender {
    float totalAmount = [self.myTextField.text floatValue];
    NSString* tipAmount = [NSString stringWithFormat:@"$%f",[self calculateTip:totalAmount]];
    self.tipLabel.text = tipAmount;
}

-(float)calculateTip:(float)total{
    float tipPercentage = [self.tipPercentageTextField.text floatValue] ? [self.tipPercentageTextField.text floatValue] / 100 : 0.5;
    return total * tipPercentage;
}


@end

