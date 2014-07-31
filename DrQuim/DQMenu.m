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
    
        [self setName:@"MENU"];
//        self.seletorPausaSkScene= pausaScene;
        
        [self configuraTitulo];
        [self configuraNavegacao];
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
    
    //carrega o array com as opçoes
    self.opcoesMenu=[self configuraOpcoesMenu];
    
}

-(NSArray*)configuraOpcoesMenu{
    NSArray *arrayRetorno=[DQConfigMenu opcoesMenuPrincial];
    
    float ultimoY=self.titulo.frame.size.height+self.titulo.position.y +500;
    
    
    for (int i=0; i< [arrayRetorno count]; i++) {

        DQOpcaoMenu *opcaoMenu=[[DQOpcaoMenu alloc]initOpcaoTitulo:[arrayRetorno objectAtIndex:i]];
        [opcaoMenu setAnchorPoint:CGPointMake(0.5, 0)];
    
        [opcaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height - ultimoY)];
        
        [opcaoMenu setName:[arrayRetorno objectAtIndex:i]];
        [opcaoMenu configuraConteudoMenu];
        
        ultimoY= ultimoY + opcaoMenu.frame.size.height + 20;
        
        [self addChild:opcaoMenu];
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
            i= [arrayNodes count];
            [self.scene setPaused:NO];
        }
    }

    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
}

-(void)controlaNavegacaoMenu{
    
}

-(void)esconderMenu{
    //[self removeFromParent];
    [self.parent performSelector:(self.seletorPausaSkScene)];
}

-(void)realcarMenu{
    return;
}

@end
