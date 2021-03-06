//
//  DQMissaoControle.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissaoControle.h"

@implementation DQMissaoControle

-(id)initCena:(SKScene*)cenaRecebida{
    if (self=[super init]) {
        //Atribui a cena recebida por parâmetro á cena em que a Missao está acontecendo
        self.cena = cenaRecebida;
        
        //Inicia na parte 0
        self.parteAtual = 0;
        
        //E sem nenhuma missão
        self.emMissao = NO;
        
        //Define a próxima missão (a primeira)
        self.proximaMissao = 1;
        
        //Apresentando a próxima missão (no caso, a primeira)
        self.missao = [[DQMissao alloc] initMissao:self.proximaMissao];
        
        
        [self colocarBalaoDeMissao];
    }
    return self;
}


-(void)colocarBalaoDeMissao{
    if (self.balao == nil) {
        
        self.balao = [[SKSpriteNode alloc]initWithImageNamed:@"BalaoAlerta"];
        [self.balao setName:@"balaoMissao"];
        SKTextureAtlas *pastaFrames = [SKTextureAtlas atlasNamed:@"BalaoMissao"];
        
        NSInteger numImagens = pastaFrames.textureNames.count;
        NSMutableArray *frames =[[NSMutableArray alloc]init];
        
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"%d", i];
            SKTexture *temp = [pastaFrames textureNamed:textureName];
            [frames addObject:temp];
        }
        
        [self.balao runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:frames
                                                                             timePerFrame:0.3f
                                                                                   resize:NO
                                                                                  restore:YES]] withKey:@"animandoBalao"];
        
        self.balao.size = CGSizeMake(50, 50);
        [self.balao setAnchorPoint:CGPointMake(0, 0)];
    }
    
    
    SKNode *NPC = [[self.cena childNodeWithName:@"mundo"]childNodeWithName:self.missao.disparador];
    
    if (NPC != nil && !self.emMissao && ![[self.cena childNodeWithName:@"mundo"]childNodeWithName:@"balaoMissao"]) {
        
        
        [self.balao setPosition:CGPointMake(NPC.position.x, NPC.position.y+160)];
        [[self.cena childNodeWithName:@"mundo"]addChild:self.balao];
    }
    
}
-(void)atualizarCena :(SKScene*)cenaRecebida{
    
    self.cena = cenaRecebida;
}

-(BOOL)iniciarNovaMissaoNPC:(NSString*)NPC{
    
    if([self.missao podeIniciarComNPC:NPC]){
        self.emMissao = YES;
        [self.balao removeFromParent];
        return YES;
    }
    else{
        return NO;
    }
}


//TODO - AO INVÉZ DE UM ITEM PASSADO POR PARAMETRO, CONFERIR NO INVENTÁRIO
-(BOOL)passarParteMissao:(NSString *)NPC inventario:(NSArray*)items{
    
    Boolean podePassar = false;
    
    //Verifica se tem os pré-requisitos para passar de parte (dentro de uma missão)
    for (int i = 0;i < items.count ; i++) {
        
        NSString *item = [items objectAtIndex:i];
        if([self.missao podePassarComNPC:NPC Item:item Parte:self.parteAtual]){
            podePassar = true;
            break;
        }
    }
    if (items.count == 0) {
        if([self.missao podePassarComNPC:NPC Item:@"" Parte:self.parteAtual]){
            podePassar = true;
        }
    }
    
    if(podePassar){
        self.parteAtual++;
        //retorna que a parte passou
        return YES;
    }
    else{
        //retorna que a parte não passou
        return NO;
    }
}
//TODO - COLOCAR MENSSAGENS
//método chamado quando a missão chega ao fim
-(void)fimDaMissao{
    
    self.emMissao = NO;
    self.proximaMissao++;
    self.parteAtual = 0;
    self.missao = [[DQMissao alloc] initMissao:self.proximaMissao];
    [self colocarBalaoDeMissao];
}
@end
