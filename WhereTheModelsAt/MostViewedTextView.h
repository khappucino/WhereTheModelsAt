//
//  MostViewedTextView.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MostViewedQuestionsViewModel.h"

@interface MostViewedTextView : UITextView <MostViewedQuestionsViewModelProtocol>
- (void)bindTo:(MostViewedQuestionsViewModel *)viewModel;
@end
