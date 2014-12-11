//
//  DQVila.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 12/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQVila.h"

@implementation DQVila


#pragma mark Inicialização Fase
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
    }else{
        self.mostrandoContador=YES;
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
        [npc setZPosition:50.0f];
        [npc setName:nomeNPC];
        
        [self.npcs addObject:npc];
        [self.mundo addChild:npc];
    }
}

#pragma mark Métodos Removidos!
//Removido pois agora temos o controlador de fases
//-(void)apresentarCenaMaleta{
//    //Remove o som
//    [self.controleSom pararSom];
//
//    DQTransformacaoTela *cenaTransformacoes=[[DQTransformacaoTela alloc]initWithSize:self.view.bounds.size];
//
//    self.posicaoJogador=self.jogador.position;
//    [self.view presentScene:cenaTransformacoes];
//}
//
//Removido! pois agora a transicao será feita pelo controle de missoes
-(void)apresentarCenaBronca{
    DQCenaBronca *cenaBronca=[[DQCenaBronca alloc]initCena:self.view.bounds.size cena:self];

    self.jogador.controleMissoes.parteAtual++;
    [self.view presentScene:cenaBronca];
}


-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if([self.jogador.controleMissoes emMissao] && [self.jogador.controleMissoes.missao.ID isEqual:@"Missao02"] && self.jogador.controleMissoes.parteAtual == 5 && ![self childNodeWithName:@"falasDoJogo"]){
        self.jogador.controleMissoes.parteAtual++;
    }
    if([self.jogador.controleMissoes emMissao] && [self.jogador.controleMissoes.missao.ID isEqual:@"Missao03"] && self.jogador.controleMissoes.parteAtual == 2 && ![self childNodeWithName:@"falasDoJogo"] && !self.apresentouTransformacao){
        
        DQViewControllerInfoTransformacao *infoTransformacao = [[DQViewControllerInfoTransformacao alloc]init];
        
        [self.view.window.rootViewController presentViewController:infoTransformacao animated:NO completion:nil];
        self.apresentouTransformacao = true;
        
    }
    
    
    
}

//
//
//Removido, pois teremos que definir um método definitivo para mostrar a Cena dos NPCs
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    SKNode *nodeQuimm=[self.mundo nodeAtPoint:[[touches anyObject]locationInNode:self.mundo]];
//
//    //Verifica se esta sem missao e se tocou no Dr. Quimm
//    if ((![self.jogador.controleMissoes emMissao] && [self.jogador.controleMissoes.missao.ID isEqual:@"Missao00"])&&([nodeQuimm.name isEqualToString:@"Quimm"])) {
//        //Tocando abre a maleta
//        [self.controleTransicaoScenas mudarDeFase:11 Scene:self];
//    }else{
//        [super touchesBegan:touches withEvent:event];
//    }
//}
//
//REMOVIDO, pois nao esta sendo usado!
//-(id)initFase:(int)fase Size:(CGSize)size{
//    if(self=[super initFase:fase Size:size]){
//        self.falouCurandeiroCacadaCoelho=[DQControleUserDefalts falouCurandeiroCacadaCoelho];
//    }
//
//    return self;
//}

@end

