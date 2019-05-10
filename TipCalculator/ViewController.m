//
//  ViewController.m
//  TipCalculator
//
//  Created by Frank Chen on 2019-05-10.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, assign) float billAmount;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (nonatomic,strong) NSNotificationCenter* notificationCenter;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (nonatomic, assign) float tipPercentage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewYPositionConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self.notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboarControl:)];
    [self.view addGestureRecognizer:tapGesture];
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
        self.tipPercentage = [self.tipPercentageTextField.text floatValue] / 100;
        
    } else if (self.tipSlider.value){
        self.tipPercentage = self.tipSlider.value / 100;
    
    } else{
       
        self.tipPercentage = 0.15;
    }
    return total * self.tipPercentage;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    self.viewYPositionConstraint.constant = -100;
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.viewYPositionConstraint.constant = 0;
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentage = sender.value;
    float billAmount = [self.myTextField.text floatValue];
    float tipAmount = billAmount * self.tipPercentage / 100;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.myTextField) {
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        float totalAmount = [newString floatValue];
        NSString* tipAmount = [NSString stringWithFormat:@"$%0.2f",[self calculateTip:totalAmount]];
        self.tipLabel.text = tipAmount;
    } else if (textField == self.tipPercentageTextField){
        NSString* newTip = [textField.text stringByReplacingCharactersInRange:range withString:string];
        float tipPercentage = [newTip floatValue] / 100;
        float totalAmount = [self.myTextField.text floatValue];
        float tipAmount = tipPercentage * totalAmount;
        self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    }
    return YES;
}



- (void) dealloc{
    [self.notificationCenter removeObserver:self];
}

-(void)keyboarControl:(UITapGestureRecognizer*)sender{
    [self.myTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
}

@end

