//
//  DQMenuConfiguracao.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuConfiguracao.h"

@implementation DQMenuConfiguracao

@synthesize indexAtual;

-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        [self setName:@"Configurações"];
        
        [DQControleUserDefalts setSonsMudo:NO];
        [DQControleUserDefalts setMusicaMuda:NO];
        
        [self atualizaBarras];
    }
    return self;
}

-(void)prepararExibicao{
    [self configuraTitulo];
    [self configuraBarraStatus];
    [self configuraBotaoMudo];
    [self atualizaBarras];
}

-(void)configuraTitulo{
    
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:90.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    for (int i=0; i<[arrayNodes count];i++) {
        SKSpriteNode *spriteTocado=[arrayNodes objectAtIndex:i];
        
        if ([spriteTocado.name isEqualToString:@"volumeSom"]) {
            CGPoint pontoConvertido=[self convertPoint:posToque toNode:spriteTocado];
            float valorAtualizar=pontoConvertido.x/spriteTocado.frame.size.width;
            
            if (valorAtualizar >1) {
                valorAtualizar=1;
            }
            
            [DQControleUserDefalts setVolumeSons:valorAtualizar];
            [self atualizaBarras];
            
            i=(int)[arrayNodes count];
        }
        
        if ([spriteTocado.name isEqualToString:@"volumeMusica"]) {
            CGPoint pontoConvertido=[self convertPoint:posToque toNode:spriteTocado];
            float valorAtualizar=pontoConvertido.x/spriteTocado.frame.size.width;
            
            if (valorAtualizar >1) {
                valorAtualizar=1;
            }
            
            [DQControleUserDefalts setVolumeMusica:valorAtualizar];
            [self atualizaBarras];
            
            i=(int)[arrayNodes count];
        }
        
        if ([spriteTocado.name isEqualToString:@"mudoMusica"]) {
            if ([DQControleUserDefalts musicaMuda]) {
                [DQControleUserDefalts setMusicaMuda:NO];
                [self atualizaBarras];
                
                i=(int)[arrayNodes count];
            }else{
                [DQControleUserDefalts setMusicaMuda:YES];
                [self atualizaBarras];
                
                i=(int)[arrayNodes count];
            }
        }
        
        if ([spriteTocado.name isEqualToString:@"mudoSons"]) {
            if ([DQControleUserDefalts sonsMudo]) {
                [DQControleUserDefalts setSonsMudo:NO];
                [self atualizaBarras];
                
                i=(int)[arrayNodes count];
            }else{
                [DQControleUserDefalts setSonsMudo:YES];
                [self atualizaBarras];
                
                i=(int)[arrayNodes count];
            }
        }
        
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
    
    [self atualizaBarras];
}

-(void)esconderMenu{
    
    [self atualizaBarras];
    [self removeFromParent];
}

-(void)configuraBarraStatus{
    SKLabelNode *labelVolumeMusica=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    [labelVolumeMusica setText:@"Música"];
    [labelVolumeMusica setPosition:CGPointMake(CGRectGetMinX(self.frame)+100, self.titulo.position.y-200)];
    
    self.fundoVolumeMusica=[self fundoOpcao:CGPointMake(labelVolumeMusica.position.x+labelVolumeMusica.frame.size.width, labelVolumeMusica.position.y-10)];
    [self.fundoVolumeMusica setName:@"volumeMusica"];
    
    CGSize sizeBarra=CGSizeMake(self.fundoVolumeMusica.frame.size.width-22,self.fundoVolumeMusica.frame.size.height-18 );
    
    self.volumeMusica=[[DQBarraStatus alloc]initComRed:236 Green:146 Blue:1 size:sizeBarra];
    
    [self.volumeMusica setName:@"volumeMusica"];
    [self.volumeMusica setPosition:CGPointMake(self.fundoVolumeMusica.position.x+14,self.fundoVolumeMusica.position.y+10 )];
    [self.volumeMusica setZPosition:self.fundoVolumeMusica.zPosition-1];
    
    [self addChild:self.fundoVolumeMusica];
    [self addChild:labelVolumeMusica];
    [self addChild:self.volumeMusica];
    
    
    SKLabelNode *labelVolumeSons=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    [labelVolumeSons setText:@"Efeitos"];
    [labelVolumeSons setPosition:CGPointMake(labelVolumeMusica.position.x, labelVolumeMusica.position.y-self.fundoVolumeMusica.frame.size.height - 20)];
    
    self.fundoVolumeSons=[self fundoOpcao:CGPointMake(labelVolumeSons.position.x+labelVolumeSons.frame.size.width, labelVolumeSons.position.y-10)];
    [self.fundoVolumeSons setName:@"volumeSom"];
    
    self.volumeSom=[[DQBarraStatus alloc]initComRed:236 Green:146 Blue:1 size:sizeBarra];
    
    [self.volumeSom setName:@"volumeSom"];
    [self.volumeSom setPosition:CGPointMake(self.fundoVolumeSons.position.x+14,self.fundoVolumeSons.position.y+10 )];
    [self.volumeSom setZPosition:self.fundoVolumeSons.zPosition-1];
    
    [self addChild:self.fundoVolumeSons];
    [self addChild:labelVolumeSons];
    [self addChild:self.volumeSom];
}

-(void)configuraBotaoMudo{
    self.botaoMudoMusica=[SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"comSom"]];
    self.botaoMudoSons=[SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"comSom"]];
    
    [self.botaoMudoMusica setName:@"mudoMusica"];
    [self.botaoMudoSons setName:@"mudoSons"];
    
    [self addChild:self.botaoMudoMusica];
    [self addChild:self.botaoMudoSons];
    
    [self.botaoMudoMusica setPosition:CGPointMake(self.fundoVolumeMusica.position.x + self.fundoVolumeMusica.frame.size.width +30, self.fundoVolumeMusica.position.y+30)];
    
    [self.botaoMudoSons setPosition:CGPointMake(self.fundoVolumeSons.position.x + self.fundoVolumeSons.frame.size.width +30, self.self.fundoVolumeSons.position.y+30)];
    
}

-(SKSpriteNode*)fundoOpcao:(CGPoint)posicao{
    SKSpriteNode *spriteRetorno=[SKSpriteNode spriteNodeWithImageNamed:@"SeletorConfig"];
    
    [spriteRetorno setAnchorPoint:CGPointMake(0, 0)];
    [spriteRetorno setPosition:posicao];
    [spriteRetorno setZPosition:10];
    [spriteRetorno setColor:[UIColor colorWithRed:27.0/255.0 green:42.0/255.0 blue:36.0/255.0 alpha:1.0]];
    
    return spriteRetorno;
}

-(void)atualizaBarras{
    
    if ([DQControleUserDefalts sonsMudo]) {
        [self.botaoMudoSons setTexture:[SKTexture textureWithImageNamed:@"semSom"]];
    }else{
        [self.botaoMudoSons setTexture:[SKTexture textureWithImageNamed:@"comSom"]];
    }
    
    if ([DQControleUserDefalts musicaMuda]) {
        [self.botaoMudoMusica setTexture:[SKTexture textureWithImageNamed:@"semSom"]];
    }else{
        [self.botaoMudoMusica setTexture:[SKTexture textureWithImageNamed:@"comSom"]];
    }
    
    [self.volumeMusica atualizarBarra:[DQControleUserDefalts volumeMusica]*100];
    [self.volumeSom atualizarBarra:[DQControleUserDefalts volumeSons]*100];
    
    if ([self.parent.scene respondsToSelector:@selector(atualizaSomMusicaFundo)]) {
        [self.parent.scene performSelector:@selector(atualizaSomMusicaFundo)];
    }
    
}

@end
