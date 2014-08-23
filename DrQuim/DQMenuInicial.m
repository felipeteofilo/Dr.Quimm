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
        //configura background da scene
        SKSpriteNode *fundoTela=[SKSpriteNode spriteNodeWithImageNamed:@"ImagemInicioJogo"];
        [fundoTela setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [fundoTela setZPosition:-50.0f];
        [fundoTela setAlpha:0.9f];
        fundoTela.xScale=-1;
        [self addChild:fundoTela];
        
        self.mensagemCarregando=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
        [self.mensagemCarregando setText:@"Dr. Quimm"];
        [self.mensagemCarregando setFontSize:190.0f];
        [self.mensagemCarregando setFontColor:[UIColor colorWithRed:35.5/255.0f green:50.0/255.0f blue:44.0/255.0f alpha:1.0]];
        
        [self.mensagemCarregando setPosition:CGPointMake(600, CGRectGetMidY(self.frame)+100)];
        [self.mensagemCarregando setAlpha:0.0f];
        
        [self addChild:self.mensagemCarregando];
        
        SKLabelNode *teste=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
        SKSpriteNode *teste2=[SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(200, 200)];
        
        [teste setText:@"teste"];
        [teste2 setName:@"teste"];
        [teste2 setPosition:CGPointMake(200, 200)];
        //[self addChild:teste2];
        //[teste2 addChild:teste];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    
    [self animarMensagem];
    
    if ([DQControleUserDefalts primeiraExecucaoDispositivo]) {
        [self configuracoesInicial];
    }
}

-(void)animarMensagem{
    [self.mensagemCarregando runAction:[SKAction sequence:@[[SKAction fadeInWithDuration:1.5],[SKAction waitForDuration:0.5]]] completion:^{
        [self iniciarJogo];
    }];
}

-(void)atualizarTextoMensagem{
    NSString *textoMensagem=[NSString stringWithFormat:@"%@.",self.mensagemCarregando.text];
    
    [self.mensagemCarregando setText:textoMensagem];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    
    SKNode *nodeTocado=[self nodeAtPoint:posToque];
    
    if ([nodeTocado.name isEqualToString:@"teste"]) {
        [DQControleUserDefalts setRodouCutSceneFase:1 Valor:NO];
        [DQControleUserDefalts setRodouCutSceneFase:2 Valor:NO];
        [DQControleUserDefalts setFaseAtual:1];
        [DQControleUserDefalts setVolumeMusica:50.0];
        [DQControleUserDefalts setVolumeSons:50.];
    }
}

-(void)configuracoesInicial{
    [DQControleUserDefalts setRodouCutSceneFase:1 Valor:NO];
    [DQControleUserDefalts setRodouCutSceneFase:2 Valor:NO];
    [DQControleUserDefalts setFaseAtual:1];
    [DQControleUserDefalts setVolumeMusica:50.0];
    [DQControleUserDefalts setVolumeSons:50.];
    [DQControleUserDefalts setEstadoJogadorVida:100 Fome:100 Sede:100 Respeito:0];
    
    [DQControleUserDefalts atualizarPrimeiraExecucao];
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
