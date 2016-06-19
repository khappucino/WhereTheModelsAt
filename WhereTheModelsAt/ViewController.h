//
//  ViewController.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MostRecentQuestionsViewModel.h"
#import "MostViewedQuestionsViewModel.h"

@interface ViewController : UIViewController <MostRecentQuestionsViewModelProtocol, MostViewedQuestionsViewModelProtocol>

@end

