//
//  QuestionsAssembly.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Typhoon/Typhoon.h>
@class QuestionsService;
@class ModelRepository;
@class QuestionsObservableImpl;
@class MostRecentQuestionsViewModel;
@class MostViewedQuestionsViewModel;
@class ViewController;
@class RecentQuestionsTableView;
@class MostViewedTextView;

@interface QuestionsAssembly : TyphoonAssembly
- (QuestionsService *)questionsService;
- (ModelRepository *)modelRepository;
- (QuestionsObservableImpl *)questionsObservableImpl;
- (MostRecentQuestionsViewModel *)recentQuestionsViewModel;
- (MostViewedQuestionsViewModel *)mostViewedQuestionsViewModel;
- (ViewController *)viewController;
- (RecentQuestionsTableView *)recentQuestionsTableView;
- (MostViewedTextView *)mostViewedTextView;
@end
