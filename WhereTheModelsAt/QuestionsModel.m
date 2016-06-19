//
//  QuestionsModel.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "QuestionsModel.h"
#import "Question.h"
static NSString *const kItemKey = @"items";
static NSString *const kTitleKey = @"title";
static NSString *const kViewCountKey = @"view_count";

@interface QuestionsModel()
@property (nonatomic, strong) NSArray<Question *> *questions;
@end

@implementation QuestionsModel

#pragma mark - QuestionsModel factory
+ (QuestionsModel *)questionModelWithData:(NSData *)data {
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error != nil) {
        return nil;
    }
    else {
        NSArray *items = [json objectForKey:kItemKey];
        if (items) {
            NSMutableArray<Question *> *questions = [NSMutableArray new];
            for(NSDictionary *dict in items) {
                Question *question = [[Question alloc] init];
                question.title = dict[kTitleKey];
                question.views = dict[kViewCountKey];
                [questions addObject:question];
            }
            QuestionsModel *questionsModel = [[QuestionsModel alloc] init];
            questionsModel.questions = [questions copy];
            return questionsModel;
        }
        else {
            return nil;
        }
    }
}


#pragma mark - Public accessors
- (NSArray<Question *> *)allQuestions {
    return self.questions;
}

- (NSUInteger)numberOfQuestions {
    return self.questions.count;
}

- (Question *)questionForIndex:(NSUInteger)index {
    if (index >= self.questions.count) {
        return nil;
    }
    else {
        return self.questions[index];
    }
}

@end
