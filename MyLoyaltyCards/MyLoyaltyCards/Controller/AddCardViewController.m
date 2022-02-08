//
//  AddCardViewController.m
//  MyLoyaltyCards
//
//  Created by cristian on 26/08/21.
//

#import "AddCardViewController.h"
#import "Card.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddCardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *UINomeAzienda;
@property (weak, nonatomic) IBOutlet UITextField *UICodiceCliente;
@property (weak, nonatomic) IBOutlet UISegmentedControl *UIFormatoCodice;
@property (weak, nonatomic) IBOutlet UIImageView *ImgLogo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *UIColore;

@property (strong, nonatomic) NSString* pathImmagine;

@end



@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Nuova carta";
    
    //imposto il delegato a sè stessi degli UITextField
    self.UINomeAzienda.delegate = self;
    self.UICodiceCliente.delegate = self;
    
    //per impostare il colore blu acceso di base
    self.UIColore.selectedSegmentTintColor = [UIColor systemBlueColor];
}



//quando schiaccio il bottone "SALVA"
- (IBAction)AddNewCard:(id)sender {
    //alert per eventuali errori
    UIAlertController * alert = [self AlertSet];
    
    //controlla che il campo nome azienda non sia vuoto
    if([self ControlTextField:self.UINomeAzienda.text] == NO){
        alert.message = @"Inserisci il nome dell'azienda";
        [self presentViewController:alert animated:YES completion:nil];
    }
    //controlla che il campo codice cliente non sia vuoto
    else if([self ControlTextField:self.UICodiceCliente.text] == NO){
        alert.message = @"Inserisci il codice cliente";
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        //creo un nuovo oggetto carta ed inserisco tutti gli attributi
        Card *nuovaCarta = [[Card alloc] initWithnomeCarta:self.UINomeAzienda.text
                                             codiceCliente:self.UICodiceCliente.text
                                                      logo:self.pathImmagine
                                              formatoCarta:[self tipoCarta:self.UIFormatoCodice]
                                                    colore:[self coloreCarta:self.UIColore]];
                
        //creo una dictionary con la nuova carta appena creata
        NSDictionary *info = @{@"NewCard":nuovaCarta};
        //invio la notifica
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNewCard"
                                                            object:self
                                                          userInfo:info];
        
        //dealloco la view e ritorno alla precedente
        [self.navigationController popViewControllerAnimated:YES];
    }
}



//quando schiaccio il bottone "AGGIUNGI LOGO"
- (IBAction)AddLogo:(id)sender {
    
    //alert per eventuali errori
    UIAlertController * alert = [self AlertSet];
    //controlla che il campo nome azienda non sia vuoto
    if([self ControlTextField:self.UINomeAzienda.text] == NO){
        alert.message = @"Inserisci il nome dell'azienda";
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        //creo l'oggetto che prenderà l'immagine
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //messo a YES per ritagliare eventualmente la foto
        picker.allowsEditing = YES;
        //setto la sorgente come photo library
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //visualizzo il picker
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    //controllo che non venga selezionato un video
    if (CFStringCompare((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        UIAlertController * alert = [self AlertSet];
        alert.message = @"Impossibile selezionare video";
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        //recupero l'immagine selezionata
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        //creo un nome univoco con il nome dell'azienda
        NSString *fileName = [@"Logo" stringByAppendingString:self.UINomeAzienda.text];
        //rinomino l'immagine
        NSString *imageName = [fileName stringByAppendingString:@".png"];
        
        //recupero il path dell'immagine
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:imageName];
        NSData* data = UIImagePNGRepresentation(chosenImage);
        [data writeToFile:path atomically:YES];
        
        //salvo il path e stampo l'immagine nell'imglogo
        self.pathImmagine = path;
        UIImage *logo = [UIImage imageWithContentsOfFile:path];
        self.ImgLogo.image = logo;
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}



//per controllare la lunghezza del testo della textfield
- (BOOL)ControlTextField:(NSString *)str{
    if(str.length > 0) return YES;
    else return NO;
}



//funzione che crea l'alert controller con l'azione di default
- (UIAlertController *)AlertSet{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Attenzione"
                                                 message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
    //azione di deefault, sparisce l'alert ma non faccio nulla
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:@"Ho capito"                                    style:UIAlertActionStyleDefault
                                            handler:nil];
    [alert addAction:defaultAction];
    return alert;
}



//cambio colore delle varie celle
- (IBAction)SelectColor:(id)sender {
    switch (self.UIColore.selectedSegmentIndex) {
        case 0:
            self.UIColore.selectedSegmentTintColor = [UIColor systemBlueColor];
            break;
        case 1:
            self.UIColore.selectedSegmentTintColor = [UIColor systemGreenColor];
            break;
        case 2:
            self.UIColore.selectedSegmentTintColor = [UIColor systemRedColor];
            break;
        case 3:
            self.UIColore.selectedSegmentTintColor = [UIColor systemYellowColor];
            break;
        default:
            NSLog(@"Inserisci un valore corretto!");
            break;
    }
}



//ritorno il colore della cella selezionata
- (NSString *)coloreCarta:(UISegmentedControl *)ui{
    switch (ui.selectedSegmentIndex) {
        case 0:
            return @"BLUE";
            break;
        case 1:
            return @"GREEN";
            break;
        case 2:
            return @"RED";
            break;
        case 3:
            return @"YELLOW";
            break;
        default:
            return @"";
            break;
    }
}



//ritorno il tipo di carta selezionato
- (NSString *)tipoCarta:(UISegmentedControl *)ui{
    switch (ui.selectedSegmentIndex) {
        case 0:
            return @"QRCODE";
            break;
        case 1:
            return @"BARCODE";
            break;
        default:
            return @"";
            break;
    }
}


//metodo per abbassare la keyboard uando premo invio
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    //abbasso la tastiera
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
