//
//  QuestionsService.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSDeferred.h"
#import "QuestionsModel.h"

@interface QuestionsService : NSObject
- (KSPromise<QuestionsModel *> *) promiseForQuestions;
@end
