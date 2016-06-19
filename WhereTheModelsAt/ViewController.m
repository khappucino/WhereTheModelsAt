//
//  ViewController.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "ViewController.h"
#import "MostRecentQuestionsViewModel.h"
#import "MostViewedQuestionsViewModel.h"
#import "ModelRepository.h"

@interface ViewController ()
@property (strong, nonatomic) MostRecentQuestionsViewModel *recentQuestionsViewModel;
@property (strong, nonatomic) MostViewedQuestionsViewModel *mostViewedQuestionsViewModel;
@property (strong, nonatomic) ModelRepository *modelRepository;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

#pragma mark - Lifecycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Registering cells, setting delegates/datasources etc...
    [self setupTableView];
    [self setupTextView];
    
    // do the work and kick off all the observation
    // both the recentQuestionsViewModel and the mostViewQuestionsViewModel have
    // a reference to the same instance of the model repo, they both add themselves
    // as subscribers when they init, this is more like a connectable observable where
    // we can delay the work until we know all the subscribers are hooked up and ready to go
    // If we get someone that is late to the party they can still add themself as a subscriber
    // and they will get notified when data changes, if the data has already been fetched they
    // will immediately be updated after subscription
    [self.modelRepository fetch];
    
}


#pragma mark - helper methods
- (void)setupTableView {
    // setup cells, this could also include custom nibs as well if needed
    // the idea for this is to make the details of the tableview opaque to the viewcontroller
    for(NSString *cellNames in [self.recentQuestionsViewModel cellNamesToRegister]) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellNames];
    }

    // bind viewModels to screen
    [self.tableView setDataSource:self.recentQuestionsViewModel];
    
    // set the delegate so we know when to pump the tableview, this could have been
    // done inside the viewModel but we would need to have a weak reference to the tableview
    [self.recentQuestionsViewModel setDelegate:self];
    // If I was not lazy I would have hand made the Observable for this and we would have just
    // asked for the observable from the viewModel and handled onNext and onError
}

- (void)setupTextView {
    // If I was not lazy I would have hand made the Observable for this and we would have just
    // asked for the observable from the viewModel and handled onNext and onError
    [self.mostViewedQuestionsViewModel setDelegate:self];
}



#pragma mark - MostRecentQuestionsViewModelProtocol
- (void)updateTableView {
    // Since we are not using RX we have to make sure things are on right thread
    // Since we don't really know what thread the underlying system is using
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - MostViewedQuestionsViewModelProtocol
- (void)updateTextView {
    // Since we are not using RX we have to make sure things are on right thread
    // Since we don't really know what thread the underlying system is using
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView setAttributedText:[self.mostViewedQuestionsViewModel displayableString]];
    });
}

@end
