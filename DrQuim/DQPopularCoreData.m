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
           Composto* novoComposto = [DQCoreDataController procurarComposto:[[compostosPlist objectAtIndex:i]objectForKey:@"Nome"]];
            
            if (novoComposto == nil) {
                novoComposto =[NSEntityDescription
                               insertNewObjectForEntityForName:@"Composto"
                               inManagedObjectContext:[DQCoreDataController contextoApp]];
                
                
                novoComposto.nome = [[compostosPlist objectAtIndex:i]objectForKey:@"Nome"];
            }
            
            NSMutableArray *elementos = [[NSMutableArray alloc]init];
            
            elementos = [[compostosPlist objectAtIndex:i]objectForKey:@"Elementos"];
            
            
            novoComposto.elementos = elementos;
            
            novoComposto.imagem = [[compostosPlist objectAtIndex:i]objectForKey:@"Imagem"];
            novoComposto.formula_molecular = [[compostosPlist objectAtIndex:i]objectForKey:@"FormulaMolecular"];
            novoComposto.info_Composto= [[compostosPlist objectAtIndex:i]objectForKey:@"Info"];
            
            [compostosParaSalvar addObject:novoComposto];
        }
        
        [DQCoreDataController salvarCompostos:compostosParaSalvar];
    }
    
    
}
-(void)iniciarElementos{
    
    NSArray* elementos =[DQCoreDataController elementos];
    
    NSMutableArray *elementosParaSalvar = [[NSMutableArray alloc]init];
    if(elementos.count < [[self.TransformacoesRef objectForKey:@"Elementos"]intValue]){
        
        [self lerPlistTransformacoes];
        NSArray *elementosPlist = [self.transformacoesPlist objectForKey:@"Elementos"];
        
        for (int i = 0 ;i < elementosPlist.count; i++) {
            Elemento *novoElemento = [DQCoreDataController procurarElemento:[[elementosPlist objectAtIndex:i]objectForKey:@"Nome"]];
            
            if (novoElemento == nil) {
                novoElemento =[NSEntityDescription
                               insertNewObjectForEntityForName:@"Elemento"
                               inManagedObjectContext:[DQCoreDataController contextoApp]];
                
                novoElemento.nome = [[elementosPlist objectAtIndex:i]objectForKey:@"Nome"];
            }
            
            
            
            
            
            novoElemento.imagem = [[elementosPlist objectAtIndex:i]objectForKey:@"Imagem"];
            novoElemento.n_eletrons = [[elementosPlist objectAtIndex:i]objectForKey:@"NumeroEletrons"];
            
            novoElemento.simbolo = [[elementosPlist objectAtIndex:i]objectForKey:@"Simbolo"];
            novoElemento.info_elemento= [[elementosPlist objectAtIndex:i]objectForKey:@"Info"];
            
            [elementosParaSalvar addObject:novoElemento];
        }
        
        [DQCoreDataController salvarCompostos:elementosParaSalvar];
    }
    
    
}
-(void)iniciarReceitas{
    
    NSArray* receitas =[DQCoreDataController receitas];
    
    NSMutableArray *receitasParaSalvar = [[NSMutableArray alloc]init];
    if(receitas.count < [[self.TransformacoesRef objectForKey:@"Receitas"]intValue]){
        
        [self lerPlistTransformacoes];
        NSArray *receitasPlist = [self.transformacoesPlist objectForKey:@"Receitas"];
        
        for (int i = 0 ;i < receitasPlist.count; i++) {
            Receita *novaReceita = [DQCoreDataController procurarReceita:[[receitasPlist objectAtIndex:i]objectForKey:@"Nome"]];
            
            if (novaReceita == nil) {
                novaReceita =[NSEntityDescription
                              insertNewObjectForEntityForName:@"Receita"
                              inManagedObjectContext:[DQCoreDataController contextoApp]];
                
                
                novaReceita.nome = [[receitasPlist objectAtIndex:i]objectForKey:@"Nome"];
            }
            
            
            if([[receitasPlist objectAtIndex:i]objectForKey:@"Ligacoes"]){
                novaReceita.ligacoes = [[receitasPlist objectAtIndex:i]objectForKey:@"Ligacoes"];
            }
            
            
            novaReceita.compostos = [[receitasPlist objectAtIndex:i]objectForKey:@"Compostos"];
            
            
            novaReceita.id_item_gerar = [[receitasPlist objectAtIndex:i]objectForKey:@"ItemGerado"];
            novaReceita.descricao = [[receitasPlist objectAtIndex:i]objectForKey:@"Descricao"];
            
            novaReceita.info_conf_composto = [[receitasPlist objectAtIndex:i]objectForKey:@"Bolinhas"];
            
            
            [receitasParaSalvar addObject:novaReceita];
        }
        
        [DQCoreDataController salvarReceitas:receitasParaSalvar];
    }
    
}

-(void)iniciarReferenciasTransformacoes{
    [self iniciarElementos];
    [self iniciarCompostos];
    [self iniciarReceitas];
}

@end
