//
//  AppDelegate.m
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window2;
@synthesize webView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"iRemember.sqlite"];
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    ALAssetsLibrary *assets = [[ALAssetsLibrary alloc] init];
    __block Image *img;

    [Image MR_truncateAll];
    [localContext MR_saveNestedContexts];
    
    [assets enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                          usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                              [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                                  if (asset != nil)
                                  {
                                      img = [Image MR_createInContext:localContext];
                                  }
                                  NSURL *url = [[asset defaultRepresentation] url];
                                  if (url != nil)
                                  {
                                      img.image_path = [url absoluteString];
                                      [localContext MR_saveNestedContexts];
                                  }
                              }];
                              
                          }
                        failureBlock:^(NSError *error) {
                            //something went wrong, you can't access the photo gallery
                        }
     ];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}

@end
