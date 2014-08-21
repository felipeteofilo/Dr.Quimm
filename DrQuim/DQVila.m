//
//  DQVila.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 12/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQVila.h"

@implementation DQVila



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:2];
    }
    return self;
}

-(void)iniciarFase{
    [super iniciarFase];
    
    [self adicionaNPC];
    
    //Verifica se o jogador ja tem o contador Geiger
    if(![self.jogador estaComContadorGeiger]){
        //NAo tem esconde
        [self.hudFase esconderContador];
    }
    
    
}

-(void)adicionaNPC{
    NSArray *NPCsConfigurados = [DQConfiguracaoFase configNPCFase:self.faseAtual];
    self.npcs = [[NSMutableArray alloc]init];
    for (NSDictionary *NPC in NPCsConfigurados) {
        //armazena nome e posicao do NPC dependendo do que foi configurado.
        NSString *nomeNPC = [NPC objectForKey:@"Nome"];
        CGPoint posicaoNPC = CGPointFromString([NPC objectForKey:@"PosicaoNPC"]);
        
        //instancia o NPC dependendo de seu nome
        
        //Inicia o spriteNode daquele node com o NOME e POSICAO
        DQNpc *npc = [[DQNpc alloc] initComNome:nomeNPC naPosicao:posicaoNPC];
        
        [self.npcs addObject:npc];
        [self.mundo addChild:npc];
    }
}

-(void)apresentarCenaBronca{
    DQCenaBronca *cenaBronca=[[DQCenaBronca alloc]initCena:self.view.bounds.size cena:self];
    
    [self.view presentScene:cenaBronca];
}

-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if ((!self.apresentouCenaBronca) && ([[self.jogador.controleMissoes.missao ID]isEqualToString:@"Missão 02"])&&(self.jogador.controleMissoes.parteAtual==5)) {
        
        self.apresentouCenaBronca=YES;
        [self apresentouCenaBronca];
    }
}
@end
