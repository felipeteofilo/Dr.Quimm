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
        self.apresentouCutscene =YES;
        
        [self configuracoesFase:2];
        [self iniciarFase];
    }
    return self;
}

-(void)iniciarFase{
    [self configuracoesFase:2];
    [super iniciarFase];
    [self adicionaNPC];

    self.hudFase = [[DQHudController alloc]initHud];
    [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
    [self addChild:self.hudFase];

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
        DQnpc *npc = [[DQnpc alloc] initComNome:nomeNPC naPosicao:posicaoNPC];
        
        [self.npcs addObject:npc];
        [self.mundo addChild:npc];
    }
    
    
}
@end
