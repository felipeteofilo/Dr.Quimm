//
//  DQPopularCoreData.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQPopularCoreData.h"

@implementation DQPopularCoreData


-(id)init{
    
    if (self = [super init]) {
        [self lerPlistTransformacoesRef];
    }
    
    return self;
}

-(void)lerPlistTransformacoes{
    
    if (self.transformacoesPlist == nil) {
        
        
        NSString *caminhoArquivo = [[NSBundle mainBundle] pathForResource:@"Transformacoes" ofType:@"plist"];
        
        self.transformacoesPlist = [NSDictionary dictionaryWithContentsOfFile:caminhoArquivo];
    }
}

-(void)lerPlistTransformacoesRef{
    NSString *caminhoArquivo = [[NSBundle mainBundle] pathForResource:@"TransformacoesReferencia" ofType:@"plist"];
    
    self.TransformacoesRef= [NSDictionary dictionaryWithContentsOfFile:caminhoArquivo];
}


-(void)iniciarCompostos{
    
    NSArray* compostos =[DQCoreDataController compostos];
    
    NSMutableArray *compostosParaSalvar = [[NSMutableArray alloc]init];
    if(compostos.count < [[self.TransformacoesRef objectForKey:@"Compostos"]intValue]){
        
        [self lerPlistTransformacoes];
        NSArray *compostosPlist = [self.transformacoesPlist objectForKey:@"Compostos"];
        
        for (int i = 0 ;i < compostosPlist.count; i++) {
            Composto *novoComposto = [DQCoreDataController procurarComposto:[[compostosPlist objectAtIndex:i]objectForKey:@"Nome"]];
            
            if (novoComposto == nil) {
                novoComposto =[[Composto alloc]init];
                
                novoComposto.nome = [[compostosPlist objectAtIndex:i]objectForKey:@"Nome"];
            }
            
            
            for (int j = 0; j< [[[compostosPlist objectAtIndex:i]objectForKey:@"Elementos"]count]; i++) {
                
                NSString *nomeElemento = [[[compostosPlist objectAtIndex:i]objectForKey:@"Elementos"]objectAtIndex:i];
                
                Elemento* elementoComposto = [DQCoreDataController procurarElemento:nomeElemento];
                
                [novoComposto addElementos_compostoObject:elementoComposto];
            }
            
            
            novoComposto.imagem = [[compostosPlist objectAtIndex:i]objectForKey:@"Imagem"];
            novoComposto.formula_molecular = [[compostosPlist objectAtIndex:i]objectForKey:@"FormulaMolecular"];
            novoComposto.info_Composto= [[compostosPlist objectAtIndex:i]objectForKey:@"Info"];
            
            [compostosParaSalvar addObject:novoComposto];
        }
        
        [DQCoreDataController salvarCompostos:compostosParaSalvar];
    }
    
    
}
-(void)iniciarElementos{
    
    
    
    
}
-(void)iniciarReceitas{
    
}

@end
