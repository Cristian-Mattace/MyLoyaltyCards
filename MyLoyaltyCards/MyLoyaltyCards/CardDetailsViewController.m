//
//  CardDetailsViewController.m
//  MyLoyaltyCards
//
//  Created by cristian on 25/08/21.
//

#import "CardDetailsViewController.h"

@interface CardDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *UICodiceCliente;
@property (weak, nonatomic) IBOutlet UIImageView *UIImageCodiceCliente;
@property (weak, nonatomic) IBOutlet UIImageView *UIImageLogo;

- (CIImage*)generateBarcode;
- (CIImage *)generateQrcode;

@end

@implementation CardDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set del colore di background in base al colore scelto dall'utente per la carta
    [self stampaColoreSfondo];
    
    //imposto il titolo come nome della carta
    self.title = self.theCard.nomeCarta;
    
    //imposto la label codiceCliente come codice cliente dell'oggetto
    self.UICodiceCliente.text = self.theCard.codiceCliente;
    
    //setto l'immagine con il codice cliente barcode/qrcode
    [self stampaImgCodiceCliente];
    
    //setto l'immagine del logo tramite il path passato
    UIImage *logo = [UIImage imageWithContentsOfFile:self.theCard.logo];
    self.UIImageLogo.image = logo;
    
}



- (IBAction)eliminaCarta:(id)sender {
    
    //configuro l'alert per la conferma dell'eliminazione
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attenzione"
                                                                   message:@"Sei sicuro di voler eliminare la carta?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    //proseguo con l'eliminazione
    UIAlertAction* Si = [UIAlertAction actionWithTitle:@"Si"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
        
        //creo una dictionary con la nuova carta appena creata
        NSDictionary *info = @{@"DeleteCard":self.theCard};
        //invio la notifica
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteCard"
                                                            object:self
                                                          userInfo:info];
        
        //dealloco la view e ritorno alla precedente
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    //elimino l'alert
    UIAlertAction *No = [UIAlertAction actionWithTitle:@"No"
                                                 style:UIAlertActionStyleCancel
                                               handler:nil];
    [alert addAction:Si];
    [alert addAction:No];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



//determino il colore di background
-(void)stampaColoreSfondo{
    if([self.theCard.colore isEqualToString:@"BLUE"]){
        self.view.backgroundColor = [UIColor systemBlueColor];
    }
    else if ([self.theCard.colore isEqualToString:@"RED"]){
        self.view.backgroundColor = [UIColor systemRedColor];
    }
    else if ([self.theCard.colore isEqualToString:@"YELLOW"]){
        self.view.backgroundColor = [UIColor systemYellowColor];
    }
    else if ([self.theCard.colore isEqualToString:@"GREEN"]){
        self.view.backgroundColor = [UIColor systemGreenColor];
    }
}



//determino se stampare qrcode o barcode
-(void)stampaImgCodiceCliente{
    if([self.theCard.formatoCarta isEqualToString:@"QRCODE"]){
        CIImage *qrcode = [self generateQrcode];
        UIImage *qrcodeImage = [[UIImage alloc] initWithCIImage:qrcode];
        self.UIImageCodiceCliente.image = qrcodeImage;
    }
    else if ([self.theCard.formatoCarta isEqualToString:@"BARCODE"]){
        CIImage *barcode = [self generateBarcode];
        UIImage *barcodeImage = [[UIImage alloc] initWithCIImage:barcode];
        self.UIImageCodiceCliente.image = barcodeImage;
    }
}



//funzione per generare il barcode
-(CIImage*)generateBarcode{
    
    CIFilter *barCodeFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *barCodeData = [self.theCard.codiceCliente dataUsingEncoding:NSASCIIStringEncoding];
    [barCodeFilter setValue:barCodeData forKey:@"inputMessage"];
    [barCodeFilter setValue:[NSNumber numberWithFloat:0] forKey:@"inputQuietSpace"];
    
    CIImage *barCodeImage = barCodeFilter.outputImage;
    return barCodeImage;
}



//funzione per generare il qrcode
- (CIImage *)generateQrcode{
    NSData *stringData = [self.theCard.codiceCliente dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
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
