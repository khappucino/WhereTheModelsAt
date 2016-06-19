//
//  QuestionsModel.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface QuestionsModel : NSObject
+ (QuestionsModel *)questionModelWithData:(NSData *)data;
- (NSArray<Question *> *)allQuestions;
- (NSUInteger)numberOfQuestions;
- (Question *)questionForIndex:(NSUInteger)index;
@end
