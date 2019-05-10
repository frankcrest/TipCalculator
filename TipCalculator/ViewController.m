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

-(float)calculateTip:(NSInteger)total{
    return total * 0.15;
}


@end
