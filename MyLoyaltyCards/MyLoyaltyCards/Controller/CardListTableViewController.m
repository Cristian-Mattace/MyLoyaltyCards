//
//  CardListTableViewController.m
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import "CardListTableViewController.h"
#import "CardList.h"
#import "CardDetailsViewController.h"

@interface CardListTableViewController ()

@property (nonatomic, strong) CardList *cards;

@end

@implementation CardListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Le mie carte";
    
     //inizializzo la lista di carte
    self.cards = [[CardList alloc] init];
    
    //metto in ascolto sulle notifiche
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewCard:) name:@"AddNewCard" object:nil];
    //metto in ascolto sulle notifiche
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCard:) name:@"DeleteCard" object:nil];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.numberOfCards;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell" forIndexPath:indexPath];
    
    //recupero il dato dal modello
    Card *c = [self.cards getCard:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", c.nomeCarta];
    
    return cell;
}


//per aggiungere le carte
- (void)addNewCard:(NSNotification *)ns{
    //aggiungo la carta alla lista
    [self.cards addCard: [ns.userInfo objectForKey:@"NewCard"]];
    //aggiorno la tableview
    [self.tableView reloadData];
}


//per eliminare le carte
-(void)deleteCard:(NSNotification *)ns{
    //elimino la carta dalla lista
    [self.cards remCard: [ns.userInfo objectForKey:@"DeleteCard"]];
    //aggiorno la tableview
    [self.tableView reloadData];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //controllo che la segue sia quella che ho chiamato "segueForDetails"
    if([segue.identifier isEqualToString:@"SegueForDetails"]){
        
        //controllo che il view controller di destinazione faccia parte della classe "cardDetailsViewController"
        if([segue.destinationViewController isKindOfClass:[CardDetailsViewController class]]){
            
            //creo il viewcontroller castandolo al destinationviewcontroller della segue
            CardDetailsViewController *cd = (CardDetailsViewController *)segue.destinationViewController;
            
            //restituisce l'index path della cella interessata
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            //recupero l'oggetto interessato selezionandolo nella lista cards col metodo getFriend e con l'indexpath
            Card *c = [self.cards getCard:indexPath.row];
            
            //imposto l'oggetto del del CardDetailsViewController come quello che ho appena recuperato
            cd.theCard = c;
        }
    }
}


@end
