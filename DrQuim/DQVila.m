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
        
        self.hudFase =[[DQHud alloc]initHud];
        [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
        
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
    NSArray *NPCsConfigurados=[DQConfiguracaoFase configNPCFase:self.faseAtual];
    
    for (NSDictionary *NPC in NPCsConfigurados) {
        NSString *nomeNPC=[NPC objectForKey:@"Nome"];
        CGPoint posNPC=CGPointFromString([NPC objectForKey:@"PosicaoNPC"]);
        
        SKSpriteNode *sprite=[self criaNPC:nomeNPC naPosicao:posNPC];
        [self.mundo addChild:sprite];
    }

}

-(SKSpriteNode*)criaNPC:(NSString*)_nome naPosicao:(CGPoint)_pos{
    
    SKSpriteNode *spriteRetorno=[SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(100, 100)];

    [spriteRetorno setAnchorPoint:CGPointMake(0, 0)];
    [spriteRetorno setName:_nome];
    [spriteRetorno setPosition:_pos];
    [spriteRetorno setZPosition:0];
    
    return spriteRetorno;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *toque=[touches anyObject];
    CGPoint posToque=[toque locationInNode:self.mundo];
    
    SKNode *nodeTocado=[self.mundo nodeAtPoint:posToque];
    
    [self interagirNPC:nodeTocado];
    
    [self.jogador pararEscalar];
}

-(void)interagirNPC:(SKNode*)npc{
    //Se for de fato um NPC...
    if (npc.name!=nil) {
        NSLog(@"Tocou no NPC: %@",npc.name);
    }
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
}
@end
