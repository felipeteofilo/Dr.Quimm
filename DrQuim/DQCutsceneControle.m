//
//  DQCutsceneView.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneControle.h"

@implementation DQCutsceneControle

-(id)initComParte:(int)parte_
{
    self = [super init];
    if (self) {
        //Cria uma string que contem o caminho (path) do arquivo plist de falas
        self.plistFalaPath = [[NSBundle mainBundle] pathForResource:@"Falas" ofType:@"plist"];
        //Cria um NSDictionary com o conteudo da pList.
        self.arrayDeFalasPLists = [[NSArray alloc]initWithContentsOfFile:self.plistFalaPath];
        
        //define a parte
        self.parte = parte_;
        
        //inicia a parte dependendo do numero passado como parte
        [self iniciaFalas];
    }
    return self;
}

-(void)iniciaFalas
{
    //Aloca o arrayCutScene - Ele irá guardar os dicionarios da parte passada por parâmetro
    self.arrayCutscenes = [[NSArray alloc]init];
    self.arrayCutscenes = [self.arrayDeFalasPLists objectAtIndex:(self.parte-1)];
    NSLog(@"%lu", [self.arrayCutscenes count]);
    
    //Aloca os arrays de FALA e CENA
    self.arrayFalas = [[NSMutableArray alloc]init];
    self.arrayCenas = [[NSMutableArray alloc]init];
    
    //Instanciando as falas e cenas
    for(int i = 0; i < [self.arrayCutscenes count]; i++){
        //NSStrings temporárias
        NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Sujeito"]];
        NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Texto"]];
        NSString *fundoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Fundo"]];
        
        //FALA e CENA - Instancias
        //objeto de fala que será, posteriormente, colocada no array definitivo de falas.
        DQFala *falaTemporaria;
        //objeto de cena que será, posteriormente, colocada no array definitivo de cenas.
        DQCena *cenaTemporaria;
        
        //FALA e CENA - Conteúdo
        //inicia o objeto temporário de fala com as informações adquiridas
        falaTemporaria = [[DQFala alloc]initComSujeito:sujeitoTemporario Texto:textoTemporario];
        //inicia o objeto temporário de cena com as informações adquiridas
        cenaTemporaria = [[DQCena alloc]initComNomeDaImagem:fundoTemporario];
        
        //FALA e CENA - Adiciona as temporárias
        [self.arrayFalas addObject:falaTemporaria];
        [self.arrayCenas addObject:cenaTemporaria];
    }
    
    //TESTE PARA VER SE FUNCIONOU
    for(int i = 0; i < [self.arrayFalas count]; i++){
        NSLog(@"%i - Sujeito:%@ |Fala:%@ |Fundo:%@ ", i, [[self.arrayFalas objectAtIndex:i] sujeito], [[self.arrayFalas objectAtIndex:i] texto], [[self.arrayCenas objectAtIndex:i] nomeDaImagem]);
    }
    
}


@end
