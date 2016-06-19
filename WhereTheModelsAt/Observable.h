//
//  Observable.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//


#ifndef Observable_h
#define Observable_h
#import "QuestionsModel.h"

@protocol QuestionsObserver <NSObject>
- (void)onNext:(QuestionsModel *)QuestionsModel;
- (void)onError:(NSError *)error;
@end

@protocol QuestionsObservable <NSObject>
- (void)addSubscriber:(id<QuestionsObserver>)subscriber;
- (void)removeSubscriber:(id<QuestionsObserver>)subscriber;
@end

#endif /* Observable_h */
