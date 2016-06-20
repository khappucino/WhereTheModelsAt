//
//  ViewController.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MostRecentQuestionsViewModel;
@class MostViewedQuestionsViewModel;

@interface ViewController : UIViewController
- (void)injectRecentViewModel:(MostRecentQuestionsViewModel *)recentViewModel;
- (void)injectMostViewModel:(MostViewedQuestionsViewModel *)mostViewModel;
@end

