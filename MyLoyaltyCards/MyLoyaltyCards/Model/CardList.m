//
//  CardList.m
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import "CardList.h"


//è strettamente privata per non farla modificare dall'esterno
@interface CardList ()

@property (nonatomic, strong) NSMutableArray *list;

@end


@implementation CardList

- (instancetype) init{
    if(self = [super init]){
        //creo la lista privata seppur vuota
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSArray *) getAll{
    return self.list;
}

- (void) addCard:(Card *)c{
    [self.list addObject:c];
}

- (void) remCard:(Card *)c{
    [self.list removeObject:c];
}

- (Card *) getCard:(NSInteger)index{
    return [self.list objectAtIndex:index];
}

- (long) numberOfCards{
    return self.list.count;
}
@end
