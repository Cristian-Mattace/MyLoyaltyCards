//
//  CardList.h
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardList : NSObject

- (NSArray *) getAll;
- (void) addCard:(Card *)c;
- (void) remCard:(Card *)c;
- (Card *) getCard:(NSInteger)index;
- (long) numberOfCards;


@end

NS_ASSUME_NONNULL_END
