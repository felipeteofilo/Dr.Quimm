//
//  DQFala.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

//init com SUJEITO que fala e TEXTO do que fala
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_
{
    self = [super init];
    if(self)
    {
        self.sujeito = sujeito_;
        self.texto = texto_;
        self.nomeFoto = nil;
    }
    return self;
}

//init com SUJEITO que fala, TEXTO do que fala e NOME DA FOTO de quem fala
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_ NomeFoto:(NSString *)nomeFoto_
{
    self = [super init];
    if(self)
    {
        self.sujeito = sujeito_;
        self.texto = texto_;
        self.nomeFoto = nomeFoto_;
    }
    return self;
}

//Método de retorno VOID que mostra a fala na tela
-(void)desenhaNaTela
{
    //define o tamanho do quadrado onde os textos aparecem
    //CGRect tamanhoQuadrado = CGRectMake(0, 0, 100, CGFloat height);
    
    
     CGRect screenBound = [[UIScreen mainScreen] bounds];
     CGSize screenSize = screenBound.size;
     CGFloat screenWidth = screenSize.width;
     CGFloat screenHeight = screenSize.height;
    
    NSLog(@"TamanhoX: %0.f, TamannhoY: %0.f", screenWidth, screenHeight);

}

@end
