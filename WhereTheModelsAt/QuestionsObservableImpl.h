//
//  QuestionsObservableImpl.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observable.h"

@interface QuestionsObservableImpl : NSObject <QuestionsObservable>
- (void)updateData:(QuestionsModel *)questionsModel;
@end
