//
//  QuestionsObservableImpl.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "QuestionsObservableImpl.h"
#import "QuestionsModel.h"
@interface QuestionsObservableImpl()
@property (strong, nonatomic) QuestionsModel *questionsModel;
@property (strong, nonatomic) NSMutableSet<id<QuestionsObserver>> *subsribers;
@property (strong, nonatomic) NSString *syncToken;
@end

@implementation QuestionsObservableImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        _subsribers = [[NSMutableSet<id<QuestionsObserver>> alloc] init];
        _syncToken = @"QuestionsModelSyncToken";
    }
    return self;
}

// Notifies all the subscribers, we can call updateData to invalidate cache
- (void)updateData:(QuestionsModel *)questionsModel {
    // Cache last value
    self.questionsModel = questionsModel;
    // Just in case people go nuts and try to update the observer from different threads
    @synchronized (self.syncToken) {
        for(id<QuestionsObserver>obs in self.subsribers) {
            [obs onNext:questionsModel];
        }
    }
}

#pragma mark - QuestionsObservable protocol
- (void)addSubscriber:(id<QuestionsObserver>)subscriber {
    @synchronized (self.syncToken) {
        [self.subsribers addObject:subscriber];
        // if the value has already been fetched lets manually update the newcomer
        if (self.questionsModel) {
            [subscriber onNext:self.questionsModel];
        }
    }
}
- (void)removeSubscriber:(id<QuestionsObserver>)subscriber {
    @synchronized (self.syncToken) {
        [self.subsribers removeObject:subscriber];
    }
}

@end
