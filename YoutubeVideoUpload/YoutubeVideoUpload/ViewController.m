//
//  ViewController.m
//  YoutubeVideoUpload
//
//  Created by SOTSYS020 on 03/01/15.
//  Copyright (c) 2015 macmini17. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController (){
    UINavigationController *navController;

}
@property (nonatomic, strong) GTLServiceYouTube *youtubeService;
@property(nonatomic, strong) YouTubeUploadVideo *uploadVideo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClkVideoUpload:(id)sender {
    //Check Network Connection after that call method
    [self YoutubeShare];
    
    
}
#pragma mark -
#pragma mark - For youtube Share
#pragma mark -
-(void)YoutubeShare{
   
        if (!self.youtubeService)
        {
            self.youtubeService = [[GTLServiceYouTube alloc] init];
            self.youtubeService.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                                                   clientID:kClientID
                                                                                               clientSecret:kClientSecret];
        }
        if (![self isAuthorized]) {
            [self openAuthControllerForYouTube];
        }
        else
        {
            [self uploadVideoOnYouTube];
        }

}
- (BOOL)isAuthorized {
    return [((GTMOAuth2Authentication *)self.youtubeService.authorizer) canAuthorize];
}

-(void)openAuthControllerForYouTube
{

    navController = [[UINavigationController alloc] initWithRootViewController:[self createAuthController]];
    
    [self presentViewController:navController animated:YES completion:^{
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backYouTubeLogin:)];
        [navController.topViewController.navigationItem setLeftBarButtonItem:backBtn];
    }];
}

-(void)backYouTubeLogin:(id)sender
{
    [navController dismissViewControllerAnimated:YES completion:nil];
}


// Creates the auth controller for authorizing access to YouTube.
- (GTMOAuth2ViewControllerTouch *)createAuthController
{
    GTMOAuth2ViewControllerTouch *authController;
    //Change Your App ClientID and ClientSecret
    
    authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeYouTube
                                                                clientID:kClientID//Change
                                                            clientSecret:kClientSecret//Change
                                                        keychainItemName:kKeychainItemName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        // [Utils showAlert:@"Authentication Error" message:error.localizedDescription];
        self.youtubeService.authorizer = nil;
    } else {
        self.youtubeService.authorizer = authResult;
        [self uploadVideoOnYouTube];
    }
    [self backYouTubeLogin:nil];
}

-(void)uploadVideoOnYouTube
{
    _uploadVideo = [[YouTubeUploadVideo alloc] init];
    _uploadVideo.delegate = self;
    NSURL *VideoUrl = [[NSBundle mainBundle] URLForResource:@"videoTest" withExtension:@"MOV"];

    NSData *fileData = [NSData dataWithContentsOfURL:VideoUrl];
    NSString *title;
    NSString *description;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"'Test Video Uploaded ('EEEE MMMM d, YYYY h:mm a, zzz')"];
    title = [dateFormat stringFromDate:[NSDate date]];
    
    description = @"This is test";
    
    [self.uploadVideo uploadYouTubeVideoWithService:self.youtubeService
                                           fileData:fileData
                                              title:title
                                        description:description];
}

- (void)uploadYouTubeVideo:(YouTubeUploadVideo *)uploadVideo
      didFinishWithResults:(GTLYouTubeVideo *)video {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VideoUploadDemo" message:@"Successfully uploaded on Youtube." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
    [alert show];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
