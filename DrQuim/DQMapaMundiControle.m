//
//  DQMapaMundiController.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMapaMundiControle.h"

@implementation DQMapaMundiControle

-(id)init{
    if (self=[super init]) {
        
        [DQMapaMundiControle atualizarCoreData];

        [self carregarFasesCoreData];
    }
    
    return self;
}
-(BOOL)faseDisponivel:(int)fase{
    NSArray *requisitos=[self requisitosFase:fase];
    
    BOOL retorno=YES;
    
    NSString *tipoRequisito;
    
    //TODO:- Melhorar verificação
    if ([requisitos count]==0 ) {
        //Nao tem requisito esta disponivel
        return YES;
    }
    
    //Verifico cada requisito para a fase
    for (int i=0; i < [requisitos count];i++) {
        //Verifico qual o tipo de requisito e chamo o tratamento certo
        tipoRequisito=[[requisitos objectAtIndex:i]objectForKey:@"TipoRequisito"];

        if ([tipoRequisito isEqualToString:@"Item"]) {
            //Item
            retorno =[self atendeRequisitoItem:[[requisitos objectAtIndex:i]objectForKey:@"ObjRequisitado"]];
        
        }else if ([tipoRequisito isEqualToString:@"Respeito"]) {
            //Respeito
            retorno =[self atendeRequisitoRespeito:[[requisitos objectAtIndex:i]objectForKey:@"ObjRequisitado"]];

        }else if([tipoRequisito isEqualToString:@"Missao"]){
            //Missao Concluida
            retorno =[self atendeRequisitoMissao:[[requisitos objectAtIndex:i]objectForKey:@"ObjRequisitado"]];
        }
    }
    
    return retorno;
}

-(BOOL)atendeRequisitoItem:(NSString*)item{
    DQJogador *jogador=[DQJogador sharedJogador];
    
    if ([jogador estaComItem:item]) {
        return YES;
    }else{
    
        return NO;
    }
}

-(BOOL)atendeRequisitoRespeito:(NSString*)respeito{
//Cria um jogador para poder acessar as info dele
    DQJogador *jogador=[DQJogador sharedJogador];

    if ([jogador respeito]>=[respeito intValue]) {
        return YES;
    }else{
        return NO;
    }
}

//TODO: - Verificar oq fazer
-(BOOL)atendeRequisitoMissao:(NSString*)missao{
    return NO;
}

-(NSArray*)requisitosFase:(int)idFase{
    return [[self.fasesConfiguradas objectAtIndex:idFase-1]objectForKey:@"Requisitos"];
}

-(void)carregarFasesCoreData{
    NSArray *fasesCoreData=[DQCoreDataController pegarTodasFases];
    
    NSMutableArray *fasesMapaMundi=[NSMutableArray array];
    
    for (FaseConfigurada *fase in fasesCoreData) {
        //Configuro o dic e add ele
        //O campo Disponível é um controle a mais na verificação
        NSDictionary *infoFase=[NSDictionary dictionaryWithObjects:@[[fase requisitos],[fase id]] forKeys:@[@"Requisitos",@"idFase"]];
        
        [fasesMapaMundi addObject:infoFase];
    }
    
    self.fasesConfiguradas=fasesMapaMundi;
}
+(void)atualizarCoreData{
    NSArray *arrayFasesConfiguradas=[DQConfiguracaoFase arquivoPlist];
    int nFaseCoreData=[DQCoreDataController nFasesCoreData];
    
    if ((nFaseCoreData != [arrayFasesConfiguradas count]) || ([DQControleConfigGeral precisaAtualizarFasesCoreData])) {
        //Para cada registro no plist eu pego os requisitos e subo no coreData
        for (int i=0; i<[arrayFasesConfiguradas count]; i++) {
            //Verifica se ja tem a fase adicionada se nao tiver adiciona
            //+1 adicionado para ajustar o ID com o index do array
            if (![DQCoreDataController procurarFase:i+1]) {
                [DQCoreDataController salvarFaseID:i+1 comRequisitos:[DQConfiguracaoFase requisitosFase:i+1]];
            }
        }
    }
}

@end
