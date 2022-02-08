//
//  Card.h
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject


- (instancetype) initWithnomeCarta:(NSString *) nomeCarta
                     codiceCliente:(NSString *) codiceCliente
                              logo:(NSString *) logo
                      formatoCarta:(NSString *) formatoCarta
                            colore:(NSString *) colore;
                        

@property (nonatomic, strong) NSString *nomeCarta;
@property (nonatomic, strong) NSString *codiceCliente;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *formatoCarta;
@property (nonatomic, strong) NSString *colore;


@end

NS_ASSUME_NONNULL_END
