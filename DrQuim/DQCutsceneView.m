//
//  DQCutsceneView.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneView.h"

@implementation DQCutsceneView

-(id)initComParte:(int)parte_
{
    self = [super init];
    if (self) {
        //Cria uma string que contem o caminho (path) do arquivo plist de falas
        self.plistFalaPath = [[NSBundle mainBundle] pathForResource:@"Falas" ofType:@"plist"];
        //Cria um NSDictionary com o conteudo da pList.
        self.arrayDeFalas = [[NSArray alloc]initWithContentsOfFile:self.plistFalaPath];
        
        //define a parte
        self.parte = parte_;
        
        //inicia a parte dependendo do numero passado como parte
        [self iniciaFalas];
    }
    return self;
}

-(void)iniciaFalas
{
    self.arrayCutscenes = [[NSArray alloc]init];
    
    //sendo a parte 1, deve começar com o objeto 0: um array de contém dicionarios
    self.arrayCutscenes = [self.arrayDeFalas objectAtIndex:(self.parte-1)];
    
    //Instanciando as falas e cenas
    for(int i = 0; i < [self.arrayCutscenes count]; i++){
        NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Sujeito"]];
        NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Texto"]];
        NSString *fotoTemporaria = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Texto"]];
        
        //FALA
        //instancia de fala que será, posteriormente, colocada no array definitivo de falas
        DQFala *falaTemporaria;
        
        //teste
        NSLog(@"Fala - %i: Sujeito: %@, Texto: %@\n, Foto:", i, sujeitoTemporario, textoTemporario);
        
        
        //verifica qual construtor deve usar (Sujeito e Texto) ou (Sujeito, Texto e NomeDaFoto)
        if([[[self.arrayCutscenes objectAtIndex:i]objectForKey:@"Foto"] isEqual: @""]){
            falaTemporaria = [[DQFala alloc]initComSujeito:sujeitoTemporario Texto:textoTemporario];
        }
    }
    
    //init com SUJEITO que fala e TEXTO do que fala
    
    //init com SUJEITO que fala, TEXTO do que fala e NOME DA FOTO de quem fala
    
}


@end
