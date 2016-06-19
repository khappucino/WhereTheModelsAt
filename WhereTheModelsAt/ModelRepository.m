//
//  ModelRepository.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "ModelRepository.h"
#import "QuestionsObservableImpl.h"
#import "Observable.h"
#import "QuestionsService.h"
#import "KSDeferred.h"
#import "QuestionsModel.h"

@interface ModelRepository()
@property (strong, nonatomic) QuestionsService *service;
@property (strong, nonatomic) QuestionsObservableImpl *questionsObservable;
@end

@implementation ModelRepository

- (instancetype)initWithService:(QuestionsService *)service {
    self = [super init];
    if (self) {
        _service = service;
        _questionsObservable = [[QuestionsObservableImpl alloc] init];        
    }
    return self;
}

// This is a ghetto manual version of a PublishSubject

- (void)fetch {
    // Ask service for the model data, then update all the subscribers and cache the value
    KSPromise *questionPromise = [self.service promiseForQuestions];
    [questionPromise then:^id _Nullable(QuestionsModel * _Nullable questionsModel) {
        // This value is cached in the observable implementation, we can invalidate by calling fetch again
        [self.questionsObservable updateData:questionsModel];
        return questionsModel;
    } error:^id _Nullable(NSError * _Nullable error) {
        return error;
    }];
}

- (void)addQuestionsSubscriber:(id<QuestionsObserver>)subscriber {
    // add subscribers who want to know when the questions model updates
    [self.questionsObservable addSubscriber:subscriber];
}

- (void)removeQuestionsSubscriber:(id<QuestionsObserver>)subscriber {
    [self.questionsObservable removeSubscriber:subscriber];
}



@end
