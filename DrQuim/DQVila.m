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
        
        self.hudFase = [[DQHudController alloc]initHud];
        [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
        
        //Inicia com a fase 2
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:3 Fase:2];
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        //[self iniciarFase];
        
        self.missao = [[DQMissoesJogador alloc]init];
        
        //TEMPORÁRIO - inicia ele direto na missão 01
        [self.missao iniciarMissao:1];
        
        [self configuraBotaoMenu];
        NSLog(@"Missao: %i| Parte: %i", self.missao.missaoAtual, self.missao.parteDaMissao);

        [self.controleCutscenes iniciarCutscene:self Seletor:@selector(iniciarFase)];

    }
    
    return self;
}

-(void)iniciarFase{
    [super iniciarFase];
    [self adicionaNPC];
    [self addChild:self.hudFase];
    self.cutsceneEstaRodando = NO;
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
        else if([nomeNPC isEqualToString:@"Quimm"]){
            //Inicia o node com o NOME
            self.quimm = [[DQnpc alloc] initComNome:nomeNPC];
            
            //Inicia o spriteNode daquele node com o NOME e POSICAO
            [self.quimm criarSpriteNodeComNome:nomeNPC naPosicao:posicaoNPC];
            [self.quimm.spriteNode setSize:CGSizeMake(70, 100)];
            [self.mundo addChild:self.quimm.spriteNode];
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
        if ([nodeTocado.name isEqualToString:@"Maedetodos"] || [nodeTocado.name isEqualToString:@"Curandeiro"] || [nodeTocado.name isEqualToString:@"Cacador"] || [nodeTocado.name isEqualToString:@"Chefe"] || [nodeTocado.name isEqualToString:@"Quimm"]) {
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
            
            //Se foi o Dr.Quimm
            else if([nodeTocado.name isEqualToString:@"Quimm"]){
                //Chama o método de interação passando o NPC tocado
                [self interagirComNPC:self.quimm];
            }
        }
    }
    
    //Ao parar o toque, pausa sua escalada se ainda estiver escalando
    if ([self.jogador actionForKey:@"escalar"]) {
        [self.jogador pausarEscalada];
    }
    
}

//FUNCIONANDO APENAS SE NÃO ESTIVER EM NENHUMA MISSÃO
-(void)interagirComNPC:(DQnpc*)npc{
    //definições importantes:
    self.cutsceneEstaRodando = NO;
    self.estaFalando = YES;
    [self.jogador pararAndar];
    

    //SEM MISSAO
    if(self.missao.missaoAtual == 0){
        //chamar as falas do Personagem dependendo do respeito
        [self.controleCutscenes mostrarFalaNaVila:self.scene Dicionario:npc.dicionarioDeFalasSemMissao Respeito:self.jogador.respeito];
    }
    
    //COM MISSAO
    //missão 01 - Ajudando a mãe de todos
    else if(self.missao.missaoAtual == 1){
        NSString *keyDaParte;
        
        //se o NPC em questão ainda não falou com o jogador
        if(!npc.falou){
            keyDaParte = [NSString stringWithFormat:@"Parte%i", self.missao.parteDaMissao];
            npc.falou = YES;
            NSLog(@"%@", keyDaParte);
        }
        //se o NPC em questão já tiver falado com a
        else{
            keyDaParte = [NSString stringWithFormat:@"Parte%iR", self.missao.parteDaMissao];
            NSLog(@"%@", keyDaParte);
        }
        
        //Mostra a fala dependendo da Key gerada
        [self.controleCutscenes mostrarFalaNaMissao:self.scene Dicionario:npc.dicionarioDeFalasMissao01 Parte:keyDaParte];
    }
    
    //chama o método que verifica se a missão deve mudar de parte ou não - e se for mudar, faz o que for necessário
    [self mudarParteMissao];
}

-(void)mudarParteMissao
{
    //se a missão for a Missão01 - Ajudando a mãe de todos
    if(self.missao.missaoAtual == 1){
        switch (self.missao.parteDaMissao) {
            case 0:
                if(self.maeDeTodos.falou){ [self.missao passarParteMissao]; }
                break;
            case 1:
                if(self.cacador.falou){ [self.missao passarParteMissao]; }
                break;
            case 2:
                if(self.maeDeTodos.falou){ [self.missao passarParteMissao]; }
                break;
            case 3:
                if(self.chefe.falou){ [self.missao passarParteMissao]; }
                break;
            case 4:
                if(self.curandeiro.falou){ [self.missao passarParteMissao]; }
                break;
            case 5:
                if(self.chefe.falou){ [self.missao passarParteMissao]; }
                break;
            case 6:
                if(self.cacador.falou){ [self.missao passarParteMissao]; }
                break;
            case 7:
                if(self.maeDeTodos.falou){ [self.missao passarParteMissao]; }
                break;
            default:
                break;
        }
        
        self.maeDeTodos.falou = NO;
        self.cacador.falou = NO;
        self.curandeiro.falou = NO;
        self.chefe.falou = NO;
        self.quimm.falou = NO;
    }
}

-(void)criarParteFase{
    [super criarParteFase];
    
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        if (self.parteFaseAtual +1 <= self.nPartesFase ) {
            
            if (![self.backgroundFuturo childNodeWithName:nomeEscalavel]) {
                NSArray *arrayEscalaveis=[DQConfiguracaoFase escalavelFase:self.faseAtual Parte:self.parteFaseAtual +1];
                
                for (int i=0;i<[arrayEscalaveis count];i++) {
                    //Cada posicao no array de escalaveis tem apenas 2 posicoes (Ponto inicial e ponto Final do escalavel)
                    CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
                    CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
                    
                    //cria a escada e seta o corpo fisico dela
                    DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
                    
                    [super escadaCategoria:escada];
                    
                    [self.backgroundFuturo addChild:escada];
                    
                    
                }
            }
        }
    }else{
        if (self.parteFaseAtual -1 > 0) {
            
            if (![self.backgroundAnterior childNodeWithName:nomeEscalavel]) {
                NSArray *arrayEscalaveis=[DQConfiguracaoFase escalavelFase:self.faseAtual Parte:self.parteFaseAtual -1];
                
                for (int i=0;i<[arrayEscalaveis count];i++) {
                    //Cada posicao no array de escalaceis tem apenas 2 posicoes (POnto inicial e ponto Final do escalavel)
                    CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
                    CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
                    
                    //cria a escada e seta o corpo fisico dela
                    DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
                    
                    [super escadaCategoria:escada];
                    
                    [self.backgroundAnterior addChild:escada];
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
    
    //verifica para onde o jogador deve escalar 
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
    
    
}
@end
