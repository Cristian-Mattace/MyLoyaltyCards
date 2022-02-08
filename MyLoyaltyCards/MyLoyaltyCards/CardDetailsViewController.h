//
//  CardDetailsViewController.h
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import <UIKit/UIKit.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardDetailsViewController : UIViewController

//oggetto Card, che corrisponderà con l'oggetto selezionato nella lista
@property (nonatomic, strong) Card *theCard;

@end

NS_ASSUME_NONNULL_END
