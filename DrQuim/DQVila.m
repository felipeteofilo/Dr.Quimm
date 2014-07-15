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
    if (self=[super initWithSize:size]) {
        [self configuracoesFase:2];
        
        self.hudFase = [[DQHudController alloc]initHud];
        [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
        
        //Inicia com a fase 2
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:2];
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        [self iniciarFase];
        [self addChild:self.hudFase];
    }
    
    return self;
}

-(void)iniciarFase{
    [super iniciarFase];
    [self adicionaNPC];
}


-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    [self.hudFase atualizarHud];
}

-(void)adicionaNPC{
    NSArray *NPCsConfigurados = [DQConfiguracaoFase configNPCFase:self.faseAtual];
    
    for (NSDictionary *NPC in NPCsConfigurados) {
        //armazena nome e posicao do NPC dependendo do que foi configurado.
        NSString *nomeNPC = [NPC objectForKey:@"Nome"];
        CGPoint posicaoNPC = CGPointFromString([NPC objectForKey:@"PosicaoNPC"]);
        
        //instancia o NPC dependendo de seu nome
        if([nomeNPC isEqualToString:@"Maedetodos"]){
            //Inicia o node com o NOME
            self.maeDeTodos = [[DQnpc alloc] initComNome:nomeNPC];
            
            //Inicia o spriteNode daquele node com o NOME e POSICAO
            [self.maeDeTodos criarSpriteNodeComNome:nomeNPC naPosicao:posicaoNPC];
            [self.mundo addChild:self.maeDeTodos.spriteNode];
        }
        else if([nomeNPC isEqualToString:@"Cacador"]){
            //Inicia o node com o NOME
            self.cacador = [[DQnpc alloc] initComNome:nomeNPC];
            
            //Inicia o spriteNode daquele node com o NOME e POSICAO
            [self.cacador criarSpriteNodeComNome:nomeNPC naPosicao:posicaoNPC];
            [self.mundo addChild:self.cacador.spriteNode];
        }
        else if ([nomeNPC isEqualToString:@"Curandeiro"]){
            //Inicia o node com o NOME
            self.curandeiro = [[DQnpc alloc] initComNome:nomeNPC];
            
            //Inicia o spriteNode daquele node com o NOME e POSICAO
            [self.curandeiro criarSpriteNodeComNome:nomeNPC naPosicao:posicaoNPC];
            [self.mundo addChild:self.curandeiro.spriteNode];
        }
        else if ([nomeNPC isEqualToString:@"Chefe"]){
            //Inicia o node com o NOME
            self.chefe = [[DQnpc alloc] initComNome:nomeNPC];
            
            //Inicia o spriteNode daquele node com o NOME e POSICAO
            [self.chefe criarSpriteNodeComNome:nomeNPC naPosicao:posicaoNPC];
            [self.mundo addChild:self.chefe.spriteNode];
        }
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //armazena o toque e a posição dele
    UITouch *toque = [touches anyObject];
    CGPoint posicaoToque = [toque locationInNode:self.mundo];
    
    //Guarda o node em que tocou
    SKNode *nodeTocado = [self.mundo nodeAtPoint:posicaoToque];
    
    //METODO UM POUCO(BASTANTE) BURRO >.<
    //Se o node em que tocou for da classe DQNPC, faz o npc interagir - PENSAR EM FORMA MAIS INTELIGENTE
    if (nodeTocado.name != nil) {
        if ([nodeTocado.name isEqualToString:@"Maedetodos"] || [nodeTocado.name isEqualToString:@"Curandeiro"] || [nodeTocado.name isEqualToString:@"Cacador"] || [nodeTocado.name isEqualToString:@"Chefe"]) {
            //TESTE
            NSLog(@"tocou no NPC: %@", nodeTocado.name);
            
            //Se foi a Mãe
            if([nodeTocado.name isEqualToString:@"Maedetodos"]){
                 //Chama o método de interação passando o NPC tocado
                [self interagirComNPC:self.maeDeTodos];
            }
            
            //Se foi o Curandeiro
            else if([nodeTocado.name isEqualToString:@"Curandeiro"]){
                //Chama o método de interação passando o NPC tocado
                [self interagirComNPC:self.curandeiro];
            }
            
            //Se foi o Caçador
            else if([nodeTocado.name isEqualToString:@"Cacador"]){
                //Chama o método de interação passando o NPC tocado
                [self interagirComNPC:self.cacador];
            }
            
            //Se foi o Chefe
            else if([nodeTocado.name isEqualToString:@"Chefe"]){
                //Chama o método de interação passando o NPC tocado
                [self interagirComNPC:self.chefe];
            }
        }
    }
    
    //Ao parar o toque, para também de escalar
    [self.jogador pararEscalar];
}

//FUNCIONANDO APENAS SE NÃO ESTIVER EM NENHUMA MISSÃO
-(void)interagirComNPC:(DQnpc*)npc{
    //chamar as falas do Personagem
    [self.controleCutscenes mostrarFalaNaVila:self.scene Dicionario:npc.dicionarioDeFalasSemMissao Respeito:self.jogador.respeito];
    
    //definições importantes:
    self.cutsceneEstaRodando = YES;
    self.estaFalando = YES;
    [self.jogador pararAndar];
}

-(void)criarParteFase{
    [super criarParteFase];
    
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        if (self.parteFaseAtual +1 <= self.nPartesFase ) {
            
            if (![self.backgroundFuturo childNodeWithName:@"Escalavel"]) {
                NSArray *arrayEscalaveis=[DQConfiguracaoFase escalavelFase:self.faseAtual Parte:self.parteFaseAtual +1];
                
                for (int i=0;i<[arrayEscalaveis count];i++) {
                    //Cada posicao no array de escalaceis tem apenas 2 posicoes (POnto inicial e ponto Final do escalavel)
                    CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
                    CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
                    
                    DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
                    
                    [self.backgroundFuturo addChild:escada];
                    
                    NSLog(@"Posicao Escada X:%f Y:%f",escada.position.x,escada.position.y);
                }
            }
        }
    }else{
        if (self.parteFaseAtual -1 > 0) {
            
            if (![self.backgroundFuturo childNodeWithName:@"Escalavel"]) {
                NSArray *arrayEscalaveis=[DQConfiguracaoFase escalavelFase:self.faseAtual Parte:self.parteFaseAtual -1];
                
                for (int i=0;i<[arrayEscalaveis count];i++) {
                    //Cada posicao no array de escalaceis tem apenas 2 posicoes (POnto inicial e ponto Final do escalavel)
                    CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
                    CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
                    
                    DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
                    
                    [self.backgroundFuturo addChild:escada];
                }
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *toque=[touches anyObject];
    CGPoint posToque=[toque locationInNode:self.backgroundAtual];
    
    //Pega o node de escada na posicao do toque
    SKNode *nodeTocado=[self.backgroundAtual nodeAtPoint:posToque];

//TODO: Melhorar método de escalada
    if ([nodeTocado.name isEqualToString:nomeEscalavel]) {
        //Verifica se o Y é maior ou menor
        
        if (posToque.y > (self.jogador.position.y+20.0)) {
            //Fazer jogador escalar - Subindo
            [self.jogador escalarParaDirecao:@"C"];
            
        }else if (posToque.y < (self.jogador.position.y-20.0)){
            //Fazer jogador escalar - Descendo
            [self.jogador escalarParaDirecao:@"B"];
        }
        
    }
    
    //Se estiver falando em jogo...
    else if(self.estaFalando){
        if ([self.controleCutscenes trocarFala]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:nil];
            
        }
        else{
            
            self.estaFalando = NO;
            self.cutsceneEstaRodando = NO;
        }
    }
}
@end
