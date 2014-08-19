//
//  DQMenu.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 19/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenu.h"

@implementation DQMenu

-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        
        self.indexAtual=0;
        
        [self setName:@"MENU"];
        [self configuraTitulo];
        //[self configuraNavegacao];
        
        //carrega o array com as opçoes
        self.opcoesMenu=[self configuraOpcoesMenu];
        
        [self setScale:0.7f];
    }
    return self;
    
}
-(void)configuraTitulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:90.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
    
    SKSpriteNode *detalheMenu=[SKSpriteNode spriteNodeWithImageNamed:@"DetalheMenu.png"];
    [detalheMenu setPosition:CGPointMake(self.titulo.position.x, self.titulo.position.y-30)];
    
    [self addChild:detalheMenu];
}
-(void)configuraNavegacao{
    //Seta os nodes que faram a navegacao entre os menus
    self.proximaOpcao=[SKSpriteNode spriteNodeWithImageNamed:@"ProxMenu.png"];
    [self.proximaOpcao setName:nomeProxMenu];
    [self.proximaOpcao setAnchorPoint:CGPointMake(0, 0.5)];
    [self.proximaOpcao setPosition:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))];
    
    [self addChild:self.proximaOpcao];
    
    self.opcaoAnterior=[SKSpriteNode spriteNodeWithImageNamed:@"AnteriorMenu"];
    [self.opcaoAnterior setName:nomeAntMenu];
    [self.opcaoAnterior setAnchorPoint:CGPointMake(1, 0.5)];
    [self.opcaoAnterior setPosition:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame))];
    
    [self addChild:self.opcaoAnterior];
}

-(NSArray*)configuraOpcoesMenu{
    NSMutableArray *arrayRetorno=[NSMutableArray array];
    NSArray *arrayOpcoes=[DQConfigMenu opcoesMenuPrincial];
    
    float ultimoY=self.titulo.frame.size.height+self.titulo.position.y +400;
    
    
    for (int i=0; i< [arrayOpcoes count]; i++) {
        
        DQOpcaoMenu *opcaoMenu=[[DQOpcaoMenu alloc]initOpcaoTitulo:[arrayOpcoes objectAtIndex:i]];
        [opcaoMenu setAnchorPoint:CGPointMake(0.5, 0)];
        
        [opcaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height - ultimoY)];
        
        [opcaoMenu setName:[arrayOpcoes objectAtIndex:i]];
        [opcaoMenu configuraConteudoMenuIndex:i];
        
        ultimoY= ultimoY + opcaoMenu.frame.size.height + 20;
        
        [self addChild:opcaoMenu];
        [arrayRetorno addObject:opcaoMenu];
    }
    
    return arrayRetorno;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    for(int i=0;i<[arrayNodes count];i++){
        if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQOpcaoMenu class]]) {
            DQOpcaoMenu *opcaoTocada=[arrayNodes objectAtIndex:i];
            
            [opcaoTocada apresentarConteudo];
            
            self.indexAtual=(int)[opcaoTocada.conteudo.userData objectForKey:@"index"];
            i= (int)[arrayNodes count];
        }
    }
    
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:nomeProxMenu]) {
        DQOpcaoMenu *opcaoAtual=[self.opcoesMenu objectAtIndex:self.indexAtual];
        DQOpcaoMenu *proxOpcao;
        
        if (self.indexAtual+1 <[self.opcoesMenu count]) {
            proxOpcao=[self.opcoesMenu objectAtIndex:self.indexAtual+1];
            self.indexAtual++;
        }else{
            proxOpcao=[self.opcoesMenu objectAtIndex:0];
            self.indexAtual=0;
        }
        
        [opcaoAtual esconderConteudo];
        [proxOpcao apresentarConteudo];
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:nomeAntMenu]) {
        DQOpcaoMenu *opcaoAtual=[self.opcoesMenu objectAtIndex:self.indexAtual];
        DQOpcaoMenu *proxOpcao;
        
        if (self.indexAtual-1 < 0) {
            proxOpcao=[self.opcoesMenu objectAtIndex:[self.opcoesMenu count]-1];
            self.indexAtual=(int)[self.opcoesMenu count]-1;
        }else{
            proxOpcao=[self.opcoesMenu objectAtIndex:self.indexAtual-1];
            self.indexAtual--;
        }
        
        [opcaoAtual esconderConteudo];
        [proxOpcao apresentarConteudo];
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
}

-(void)controlaNavegacaoMenu{
    
}

-(void)esconderMenu{
    //Quero o avo do menu, pq ele é adicionado na HUD e a HUD na fase
    [self.parent.scene setPaused:NO];
    
    [self removeFromParent];
}

-(void)realcarMenu{
    return;
}
-(void)prepararExibicao{
    
}
@end
