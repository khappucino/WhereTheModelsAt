//
//  RecentQuestionsTableView.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MostRecentQuestionsViewModel.h"

@interface RecentQuestionsTableView : UITableView <MostRecentQuestionsViewModelProtocol>
- (void)bindTo:(MostRecentQuestionsViewModel *)viewModel;
@end
