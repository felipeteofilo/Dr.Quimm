//
//  DQMissao.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissao.h"

@implementation DQMissao
//Metodo para iniciar uma missao passando qual o numero da missao
-(id)initMissao :(int)missao{
    if (self = [super init]) {
        
        //Aqui lemos o arquivo pList da missao
        NSString *caminhoArrayList =[[NSBundle mainBundle] pathForResource:@"Missoes" ofType:@"plist"];
        NSArray *arquivo =[NSArray arrayWithContentsOfFile:caminhoArrayList];
        
        if (missao >= arquivo.count) {
            missao = 0;
        }
        
        
        //Aqui colocamos as informacoes da missao atual lidos do arquivo
        self.nome = [[arquivo objectAtIndex:missao]objectForKey:@"Nome"];
        self.disparador = [[arquivo objectAtIndex:missao]objectForKey:@"Disparador"];
        self.recompensa = [[arquivo objectAtIndex:missao]objectForKey:@"Recompensa"];
        self.respeito =[[[arquivo objectAtIndex:missao]objectForKey:@"Respeito"]intValue];
        self.ID =[[arquivo objectAtIndex:missao]objectForKey:@"ID"];
        
        
        //Aqui colocamos as partes da missao lidos do arquivo no array
        self.arrayPartes =[[arquivo objectAtIndex:missao]objectForKey:@"Partes"];
        
        
        //Aqui setamos a quantidade de partes dessa missao atual
        self.quantidadeDePartes = (int)self.arrayPartes.count;
        
    }
    return self;
    
}

//Metodo que retorna um boolean informando se pode ser passada a parte atual ou ja esta no fim da missao
-(Boolean)podePassarComNPC :(NSString*)nomeNPC Item:(NSString*)item Parte:(int)parte posicao:(CGPoint)posicao{
    
    BOOL estaNoPonto = true;
    
    //Lemos o npc e o item requisitado pela missao
    NSString *NPCRequisitado = [[self.arrayPartes objectAtIndex:parte]objectForKey:@"NPCRequisito"];
    NSString *itemRequisitado = [[self.arrayPartes objectAtIndex:parte]objectForKey:@"ItemRequisito"];
    
    
    if ([[self.arrayPartes objectAtIndex:parte]objectForKey:@"PontoDeAvanco"]) {
        NSString* ponto = [[self.arrayPartes objectAtIndex:parte]objectForKey:@"PontoDeAvanco"];
        CGPoint pontoDeAvanco = CGPointFromString(ponto);
        
        if (posicao.x > pontoDeAvanco.x  && posicao.x < pontoDeAvanco.x+100 && posicao.y >= pontoDeAvanco.y -20) {
            estaNoPonto = true;
        }
        else{
            estaNoPonto = false;
        }
    }
    
    //se for os items requisitados retornamos que a fase foi concluida e pode ser passada para a proxima fase
    
    
    
    
    if ([itemRequisitado isEqual:@""] && estaNoPonto) {
        if ([nomeNPC isEqual:NPCRequisitado]){
            return true;
        }
    }
    if ([nomeNPC isEqual:NPCRequisitado] && [item isEqual:itemRequisitado] && estaNoPonto) {
        return true;
    }
    
    //se nao retornamos que a parte ainda nao foi concluida
    return false;
}

//Metodo que retorna um boolean informando se pode iniciar a missao ou nao
-(Boolean)podeIniciarComNPC :(NSString*)nomeNPC{
    
    //se o NPC passado e o iniciador da missao retornamos que a missao pode ser iniciada
    if ([self.disparador isEqual:nomeNPC]) {
        return true;
    }
    //se nao retornamos que ainda nao foi iniciada a missao
    return false;
}


@end
