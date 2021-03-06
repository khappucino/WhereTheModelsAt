//
//  QuestionsAssembly.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "QuestionsAssembly.h"
#import "QuestionsService.h"
#import "ModelRepository.h"
#import "QuestionsObservableImpl.h"
#import "MostRecentQuestionsViewModel.h"
#import "MostViewedQuestionsViewModel.h"
#import "ViewController.h"
#import "RecentQuestionsTableView.h"
#import "MostViewedTextView.h"

@implementation QuestionsAssembly

- (QuestionsService *)questionsService {
    return [TyphoonDefinition withClass:[QuestionsService class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)];
    }];
}

- (ModelRepository *)modelRepository {
    return [TyphoonDefinition withClass:[ModelRepository class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self questionsService]];
        }];
    }];
}

- (QuestionsObservableImpl *)questionsObservableImpl {
    return [TyphoonDefinition withClass:[QuestionsObservableImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)];
    }];
}

- (MostRecentQuestionsViewModel *)recentQuestionsViewModel {
    return [TyphoonDefinition withClass:[MostRecentQuestionsViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithModelRepository:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self modelRepository]];
        }];
    }];
}

- (MostViewedQuestionsViewModel *)mostViewedQuestionsViewModel {
    return [TyphoonDefinition withClass:[MostViewedQuestionsViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithModelRepository:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self modelRepository]];
        }];
    }];
}

- (RecentQuestionsTableView *)recentQuestionsTableView {
    return [TyphoonDefinition withClass:[RecentQuestionsTableView class] configuration:^(TyphoonDefinition *definition) {
    }];
}

- (MostViewedTextView *)mostViewedTextView {
    return [TyphoonDefinition withClass:[MostViewedTextView class] configuration:^(TyphoonDefinition *definition) {
    }];
}

- (ViewController *)viewController {
    return [TyphoonDefinition withClass:[ViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(modelRepository) with:[self modelRepository]];
        [definition injectMethod:@selector(injectRecentViewModel:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self recentQuestionsViewModel]];
        }];
        [definition injectMethod:@selector(injectMostViewModel:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self mostViewedQuestionsViewModel]];
        }];
    }];
}

@end
