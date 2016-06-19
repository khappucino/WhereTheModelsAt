//
//  ModelRepository.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observable.h"
@class QuestionsService;

@interface ModelRepository : NSObject
- (instancetype)initWithService:(QuestionsService *)service;
- (void)fetch;
- (void)addQuestionsSubscriber:(id<QuestionsObserver>)subscriber;
- (void)removeQuestionsSubscriber:(id<QuestionsObserver>)subscriber;
@end
