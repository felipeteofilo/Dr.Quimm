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
        
        SKLabelNode *teste=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
        SKSpriteNode *teste2=[SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(200, 200)];
        
        [teste setText:@"teste"];
        [teste2 setName:@"teste"];
        [teste2 setPosition:CGPointMake(200, 200)];
        [self addChild:teste2];
        [teste2 addChild:teste];
        
        [self addChild:botaIniciar];
    }
    return self;
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

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    
    SKNode *nodeTocado=[self nodeAtPoint:posToque];
    
    if ([nodeTocado.name isEqualToString:@"Iniciar"]) {
        [self iniciarJogo];
    }
    
    if ([nodeTocado.name isEqualToString:@"teste"]) {
        [DQControleUserDefalts setRodouCutSceneFase:1 Valor:NO];
    }
}

-(void)iniciarJogo{
    int ultimaFaseJogador=[DQControleUserDefalts faseAtual];
    
    DQCutsceneTela *cutscene;
    DQFase *faseIniciar;
    
    if (ultimaFaseJogador== 0) {
        ultimaFaseJogador=1;
    }
    
    switch (ultimaFaseJogador) {
        case 1:
            
            faseIniciar=[[DQFlorestaParte1 alloc]initWithSize:self.frame.size];
            
            if (![DQControleUserDefalts rodouCutSceneFase:ultimaFaseJogador]) {
                cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador-1 Fase:faseIniciar SizeScene:self.frame.size];
                
                [DQControleUserDefalts setRodouCutSceneFase:ultimaFaseJogador Valor:YES];
            }
            
            break;
            
        case 2:
            faseIniciar=[[DQVila alloc]initWithSize:self.frame.size];
            
            if (![DQControleUserDefalts rodouCutSceneFase:ultimaFaseJogador]) {
                cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador-1 Fase:faseIniciar SizeScene:self.frame.size];
                
                [DQControleUserDefalts setRodouCutSceneFase:ultimaFaseJogador Valor:YES];
            }
            
            break;
            
        default:
            faseIniciar=[[DQFase alloc]initFase:ultimaFaseJogador Size:self.frame.size];
            
            if (![DQControleUserDefalts rodouCutSceneFase:ultimaFaseJogador]) {
                cutscene=[[DQCutsceneTela alloc]initCutScene:ultimaFaseJogador-1 Fase:faseIniciar SizeScene:self.frame.size];
                
                [DQControleUserDefalts setRodouCutSceneFase:ultimaFaseJogador Valor:YES];
            }
            break;
    }
    
    
    if (cutscene) {
        [self.view presentScene:cutscene];
    }else{
        [self.view presentScene:faseIniciar];
    }
    
}
@end
