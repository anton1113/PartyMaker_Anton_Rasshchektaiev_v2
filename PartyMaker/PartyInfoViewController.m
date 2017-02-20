//
//  PartyInfoViewController.m
//  Party Maker
//
//  Created by intern on 2/20/17.
//  Copyright © 2017 intern. All rights reserved.
//

#import "PartyInfoViewController.h"

@interface PartyInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelStartTime;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTime;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;



@property (weak, nonatomic) IBOutlet UIView *viewCircle;
@property (strong, nonatomic) UIImageView *imageViewLogo;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTopSpaceToAddPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAddPhotoHeight;

@end

@implementation PartyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBackButton];
    [self setUpLabels];
    
    self.imageViewLogo = [[UIImageView alloc] init];
    [self.viewCircle addSubview:self.imageViewLogo];
    
    [self configureSizeForSmallScreen];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// set up the circle
- (void)viewDidLayoutSubviews {
    self.viewCircle.layer.cornerRadius = self.viewCircle.frame.size.height / 2;
    self.viewCircle.layer.borderWidth = 3;
    
    UIColor *borderColor = [[UIColor alloc] initWithRed:31/255.f green:34/255.f blue:39/255.f alpha:1.f];
    [self.viewCircle.layer setBorderColor:(borderColor).CGColor];
    [self setUpImageLogo];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// configure size for iPhone 5 case
- (void)configureSizeForSmallScreen {
    double screenHeight = self.view.frame.size.height;
    
    if (screenHeight < 600) {
        self.constraintAddPhotoHeight.constant = 32;
        self.constraintTopSpaceToAddPhoto.constant = 11;
    }
}

// set up back button
- (void)setUpBackButton {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - Set up labels
// set up labels
- (void)setUpLabels {
    [self setUpNameLabel];
    [self setUpDescriptionLabel];
    [self setUpDateLabel];
    [self setUpStartTimeLabel];
    [self setUpEndTimeLabel];
}

// set up name label
- (void)setUpNameLabel {
    [self.labelName setText:self.party.name];
}

// set up description label
- (void)setUpDescriptionLabel {
    
    self.labelDescription.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelDescription.numberOfLines = 0;
    
    NSString *descriptionText = self.party.descriptionText;
    
    if (descriptionText.length > 75) {
        descriptionText = [descriptionText substringToIndex:75];
        descriptionText = [[@"\"" stringByAppendingString:descriptionText] stringByAppendingString:@"...\""];
    }
    
    [self.labelDescription setText:descriptionText];
}

// set up date label
- (void)setUpDateLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.party.startDate];
    [self.labelDate setText:stringFromDate];
}

// set up start time label
- (void)setUpStartTimeLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.party.startDate];
    [self.labelStartTime setText:stringFromDate];
}

// set up end time label
- (void)setUpEndTimeLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.party.endDate];
    [self.labelEndTime setText:stringFromDate];
}

#pragma mark - Set up image logo

- (void) setUpImageLogo {
    [self.imageViewLogo setImage:[UIImage imageNamed:self.party.logoImageName]];
    [self.imageViewLogo setFrame:CGRectMake(self.viewCircle.frame.size.height / 5.5f, self.viewCircle.frame.size.height / 7, self.viewCircle.frame.size.height / 1.5f, self.viewCircle.frame.size.height / 1.5f)];
}

# pragma mark - Handle buttons actions
- (IBAction)onLocationButtonClicked:(UIButton *)sender {
}

- (IBAction)onEditButtonClicked:(UIButton *)sender {
}

- (IBAction)onDeleteButtonClicked:(UIButton *)sender {
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
