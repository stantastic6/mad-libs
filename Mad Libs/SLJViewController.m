//
//  SLJViewController.m
//  Mad Libs
//
//  Created by Stanley Jackson on 9/8/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import "SLJViewController.h"

@interface SLJViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pluralField1;
@property (weak, nonatomic) IBOutlet UITextField *pluralField2;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *adjectiveField;
@property (weak, nonatomic) IBOutlet UITextField *verbField;
@property (weak, nonatomic) IBOutlet UIView *extraSettingsView;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteNumberLabel;
@property (weak, nonatomic) IBOutlet UIStepper *favoriteNumberStepper;
@property (weak, nonatomic) IBOutlet UISwitch *endingSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *foodSegment;



@end

@implementation SLJViewController
- (IBAction)toggleShowHide:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segment = segmentedControl.selectedSegmentIndex;
    
    if (segment == 0)//Less is selected
        [self.extraSettingsView setHidden:YES];
    else //More is selected
        [self.extraSettingsView setHidden:NO];
}
- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int numberAsInt = (int) (slider.value + 0.5f);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d", numberAsInt];
    self.sliderLabel.text = newText;
}
- (IBAction)stepperChanged:(id)sender {
    UIStepper *stepper = (UIStepper *) sender;
    int stepperNum = (int)stepper.value;
    NSString *favNum = [[NSString alloc] initWithFormat:@"%d", stepperNum];
    self.favoriteNumberLabel.text = favNum;
}

- (IBAction)buttonPressed:(id)sender {        //Check for empty text fields!
    
    if ([self.pluralField1.text isEqual: @""] || [self.pluralField2.text isEqual: @""] || [self.numberField.text isEqual: @""] || [self.adjectiveField.text isEqual: @""] || [self.verbField.text isEqual: @""]) {
        UIAlertView *emptyAlert = [[UIAlertView alloc]
                              initWithTitle:@"Error!"
                              message:@"Sorry. You must complete in all fields."
                              delegate:self
                              cancelButtonTitle:@"Okay!"
                              otherButtonTitles: nil];
        [emptyAlert show];
    }else{
    
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you ready for your story?"
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:@"Yes!"
                                                        otherButtonTitles:nil];
        


    NSString *food = nil;
    NSInteger foodIndex = self.foodSegment.selectedSegmentIndex;
    
    switch (foodIndex) {
        case 0:
            food = @"Apples";
            break;
         case 1:
            food = @"Burgers";
            break;
         case 2:
            food = @"Sandwiches";
            break;
         case 3:
            food = @"Waffles";
            break;
        default:
            break;
    }
    
    [actionSheet showInView:self.view];

    completeStory = [[NSString alloc] initWithFormat:@"My fellow %@... The time has come to address the very serious threat of feral %@. Recently, we were %@ by %@ of these creatures and we cannot allow their %@ behavior to continue.", self.pluralField1.text, self.pluralField2.text, self.verbField.text, self.numberField.text, self.adjectiveField.text];
    
    if (!self.extraSettingsView.isHidden) { //If "MORE" is selected, append extra values to main story
        NSString *extra = [NSString stringWithFormat:@" Our plan was to deploy %@ %@ to stop these vicious creatures. There were %@ survivors.", self.sliderLabel.text, food, self.favoriteNumberLabel.text];
        
        completeStory = [completeStory stringByAppendingString: extra];
        
        if (self.endingSwitch.isOn) {
            NSString *happy = [NSString stringWithFormat:@" Thanks to their efforts, we were successful in our mission and the creatures are no more!"];
            completeStory = [completeStory stringByAppendingString:happy];
        }else{
            NSString *sad = [NSString stringWithFormat:@" Unfortunately, we were unsuccessful and could not stop the creatures and their reign of terror will continue."];
            completeStory = [completeStory stringByAppendingString:sad];
        }
    }
}
}
- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.pluralField1 resignFirstResponder];
    [self.pluralField2 resignFirstResponder];
    [self.numberField resignFirstResponder];
    [self.verbField resignFirstResponder];
    [self.adjectiveField resignFirstResponder];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"A Message From Our Leader"
                          message:completeStory
                          delegate:self
                          cancelButtonTitle:@"Done"
                          otherButtonTitles:nil];
    [alert show];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
