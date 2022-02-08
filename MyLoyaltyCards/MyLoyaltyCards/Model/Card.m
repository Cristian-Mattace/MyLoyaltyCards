//
//  Card.m
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import "Card.h"

@implementation Card

//costruttore
- (instancetype) initWithnomeCarta:(NSString *)nomeCarta
                     codiceCliente:(NSString *)codiceCliente
                              logo:(NSString*)logo
                      formatoCarta:(NSString *)formatoCarta
                            colore:(NSString *)colore{
        if(self = [super init]){
            _nomeCarta = nomeCarta;
            _codiceCliente = codiceCliente;
            _logo = logo;
            _formatoCarta = formatoCarta;
            _colore = colore;
    }
    return self;
}

@end
