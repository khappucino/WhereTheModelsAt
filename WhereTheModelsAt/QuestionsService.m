//
//  QuestionsService.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "QuestionsService.h"
#import "QuestionsModel.h"

static NSString *const kQuestionsPath = @"https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow";



@implementation QuestionsService
- (KSPromise<QuestionsModel *> *) promiseForQuestions {
    KSDeferred<QuestionsModel *> * questionsDefer = [KSDeferred<QuestionsModel *> defer];
    NSURL *url = [NSURL URLWithString:kQuestionsPath];
    NSURLSessionDataTask *task = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:(url) completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil) {
            [questionsDefer rejectWithError:[NSError errorWithDomain:@"QuestionsModel fetch failed" code:0 userInfo:nil]];
        }
        else {
            QuestionsModel *model = [QuestionsModel questionModelWithData:data];
            if (model) {
                [questionsDefer resolveWithValue:model];
            }
            else {
                [questionsDefer rejectWithError:[NSError errorWithDomain:@"QuestionsModel failed to marshall from data" code:1 userInfo:nil]];
            }
        }
    }];

    [task resume];
    
    
    return questionsDefer.promise;
}


@end
