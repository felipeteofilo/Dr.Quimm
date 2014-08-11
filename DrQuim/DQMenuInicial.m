//
//  DQMenuInicial.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 10/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMenuInicial.h"

@implementation DQMenuInicial

-(id)initWithSize:(CGSize)size{
    if (self=[super initWithSize:size]) {
        SKNode *botaIniciar=[self configuraBotaoIniciar];
        [botaIniciar setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        
        
        [self addChild:botaIniciar];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInView:self.view];
    
    SKNode *nodeTocado=[self nodeAtPoint:posToque];
    
    if ([nodeTocado.name isEqualToString:@"Iniciar"]) {
        [self iniciarJogo];
    }
}

-(SKNode*)configuraBotaoIniciar{
    SKNode *botaoIniciar=[SKNode node];
    [botaoIniciar setName:@"Iniciar"];
    
    SKLabelNode *textoIniciar=[SKLabelNode labelNodeWithFontNamed:[ DQConfigMenu fonteMenu]];
    [textoIniciar setText:@"Começar"];
    [textoIniciar setPosition:CGPointMake(0,0)];
    [textoIniciar setFontSize:50.0];
    [textoIniciar setName:@"Iniciar"];
    
    [botaoIniciar addChild:textoIniciar];
    
    SKSpriteNode *imagemIniciar=[SKSpriteNode spriteNodeWithImageNamed:@"IniciarJogo"];
    [imagemIniciar setAnchorPoint:CGPointMake(0.9, 0.4)];
    [imagemIniciar setPosition:CGPointMake(textoIniciar.frame.size.width, 0)];
    [imagemIniciar setName:@"Iniciar"];
    
    [botaoIniciar addChild:imagemIniciar];
    
    
    return botaoIniciar;
}

-(void)iniciarJogo{
    [DQControleUserDefalts setFaseAtual:1];
    
    int ultimaFaseJogador=[DQControleUserDefalts faseAtual];
    
    DQCutsceneTela *cutscene;
    DQFase *faseIniciar;
    
    switch (ultimaFaseJogador) {
        case 1:
            faseIniciar=[[DQFlorestaParte1 alloc]initWithSize:self.frame.size];
            cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador-1 Fase:faseIniciar SizeScene:self.frame.size];
            
            break;
            
        case 2:
            faseIniciar=[[DQVila alloc]initWithSize:self.frame.size];
            cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador-1 Fase:faseIniciar SizeScene:self.frame.size];
            
            break;
            
        default:
            faseIniciar=[[DQFase alloc]initFase:ultimaFaseJogador Size:self.frame.size];
            cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador Fase:faseIniciar SizeScene:self.frame.size];
            
            break;
    }
    
    [self.view presentScene:cutscene];
}
@end
