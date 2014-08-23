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
-(id)initFase:(int)fase Size:(CGSize)size{
    if([super initFase:fase Size:size]){
        self.falouCurandeiroCacadaCoelho=[DQControleUserDefalts falouCurandeiroCacadaCoelho];
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
        
        [self.npcs addObject:npc];
        [self.mundo addChild:npc];
    }
}

-(void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    NSLog(@"Parte Atual Missao %i",self.jogador.controleMissoes.parteAtual);
}

-(void)apresentarCenaMaleta{
    
    if (!self.falouCurandeiroCacadaCoelho) {
        self.falouCurandeiroCacadaCoelho=YES;
        [DQControleUserDefalts setFalouCurandeiroCacadaCoelho:YES];
        
        DQTransformacaoTela *cenaTransformacoes=[[DQTransformacaoTela alloc]initWithSize:self.view.bounds.size];
        
        self.posicaoJogador=self.jogador.position;
        [self.view presentScene:cenaTransformacoes];
        
    }
}
-(void)apresentarCenaBronca{
    DQCenaBronca *cenaBronca=[[DQCenaBronca alloc]initCena:self.view.bounds.size cena:self];
    
    self.jogador.controleMissoes.parteAtual++;
    [self.view presentScene:cenaBronca];
}
-(void)apresentarFloresta2{
    self.posicaoJogador= self.jogador.position;
    
    DQFlorestaParte2 *floresta2=[[DQFlorestaParte2 alloc]initWithSize:self.size];
    
    [floresta2 salvarCenaVila:self];
    
    [self.view presentScene:floresta2];
    
    
    self.apresentouVila =YES;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)irParaFlorestaCacada{
    
}

-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    
    if (self.apresentouVila) {
        
        [self.jogador removeFromParent];
        
        self.jogador.position = self.posicaoJogador;
        
        [self.mundo addChild:self.jogador];
        self.apresentouVila =NO;
    }
    
    if (![self childNodeWithName:@"falasDoJogo"]){
        
        if ([[self.jogador.controleMissoes.missao ID]isEqualToString:@"Missao02"]) {
            
            if ((!self.apresentouCenaBronca) && (self.jogador.controleMissoes.parteAtual== 5)) {
                
                self.apresentouCenaBronca=YES;
                [self apresentarCenaBronca];
            }
            if((self.jogador.controleMissoes.parteAtual== 2)){
                
                [self apresentarFloresta2];
            }
        }
        
        if ([[self.jogador.controleMissoes.missao ID]isEqualToString:@"Missao03"]) {
            if(self.jogador.controleMissoes.parteAtual== 2){
                [self apresentarCenaMaleta];
            }
            //Assim que ele fala com o cacador vai mudar a parte da missao, entao vai p floresta
            if(self.jogador.controleMissoes.parteAtual== 4){
                [self apresentarFloresta2];
            }
        }
    }
    if (!self.mostrandoContador) {
        
        if([self.jogador estaComContadorGeiger]){
            //tem nao esconde
            [self.hudFase exibirContador];
            
            self.mostrandoContador=YES;
        }
    }
}
@end
