//
//  AppDelegate.m
//  JacobPenn_Assignment2
//
//  Created by Jacob Penn on 3/6/16.
//  Copyright © 2016 Jacob Penn. All rights reserved.
//

#import "AppDelegate.h"
#import "AudioManager.h"
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate ()
{
    int _myInt;
    //CMMotionManager *_motionManager; // just an member variable
}

// fancy property = setter and getter automatically generated
@property CMMotionManager *motionManager;


@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AudioManager *manager = [AudioManager instance];
    [manager startAudio];
    
    
    self.motionManager = [CMMotionManager new];
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical
                                                            toQueue:[NSOperationQueue mainQueue]
                                                        withHandler:^(CMDeviceMotion * motion, NSError * error) {
                                                            NSLog(@"attitude: %f %f %f",
                                                                  motion.attitude.pitch,
                                                                  motion.attitude.roll,
                                                                  motion.attitude.yaw);
                                                            AudioManager *audioManager = [AudioManager instance];
                                                            [audioManager setFrequency:100+50*motion.attitude.pitch/(M_PI*2)];
                                                            [audioManager setFrequency2:100+50*motion.attitude.roll/(M_PI*2)];
                                                            [audioManager setFrequency3:100+50*motion.attitude.yaw/(M_PI*2)];
                                                        }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
