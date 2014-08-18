//
//  DQAnimal.m
//  criacaoAnimal
//
//  Created by Leonardo de Sousa Mendes on 03/08/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQAnimal.h"
#import "DQUteis.h"

@implementation DQAnimal


-(id)initAnimalNome:(NSString*)nome sprite:(NSString*)imagemAnimal raioVisao:(float)rVisao{
    if (self =[super init]){
        self.spriteAnimal=[SKSpriteNode spriteNodeWithImageNamed:imagemAnimal];
        self.raioVisao=rVisao;
        self.nomeAnimal=nome;
        self.acoes =[NSMutableArray array];
        self.nAcoesVez=2;
        self.objetoAtracao=[[DQIsca alloc]initIsca];
        
        [self addChild:self.spriteAnimal];
        [self setName:@"animal"];
    }
    return self;
}

-(void)andar{
    SKAction *andar;
    
    if (self.dirCaminhada=='D') {
        andar=[SKAction moveByX:self.distanciaAndar y:0 duration:self.tempoAndar];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*-1;
    }else if (self.dirCaminhada=='E'){
        andar=[SKAction moveByX:(self.distanciaAndar * -1) y:0 duration:self.tempoAndar];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*1;
    }
    
    if (andar) {
        self.acaoAtual=@"andar";
        
        [self iniciarAnimacao:@"andando"];
        [self animarAnimal];
        
        [self runAction:andar completion:^{
            [self pararAnimacao];
        }];
    }
}

-(void)pararAnimacao{
    self.acaoAtual=nil;
    [self removeActionForKey:@"andando"];
    [self.spriteAnimal removeActionForKey:@"animandoAnimal"];
}

-(void)atacar{
    self.acaoAtual=@"atacar";
    
    [self iniciarAnimacao:@"atacando"];
    [self runAction:[SKAction performSelector:@selector(animarAnimal) onTarget:self]completion:^{
        [self pararAnimacao];
    }];
}

-(void)rastrearAreaBackground:(SKNode*)background{
    for (SKNode *node in background.children) {
        if (![node.name isEqualToString:self.name]) {
            if (self.raioVisao > [DQUteis calcularDistanciaPontos:self.position  ponto2:node.position]) {
                //Encontrou um jogador no raio de visao
                if ([node.name isEqualToString:@"jogador"]) {
                    //Verifica a pesonalidade do animal
                    if ([self personalidade]==Agressivo ) {
                        //DECISAO DE ATACAR LEVANDO EM CONSIDERAÇÃO A PERSONALIDADE
                        
                        //Sorteia se ataca ou se anda
                        if ([DQUteis sortearChanceSim:80]) {
                            [self.acoes insertObject:@"atacar" atIndex:0];
                        }else{
                            //Sorteou p nao atacar
                            [self.acoes insertObject:@"fugir" atIndex:0];
                        }
                    }else{
                        //Nao é agressivo
                        [self.acoes insertObject:@"fugir" atIndex:0];
                    }
                }else{
                    //Jogador nao esta no raio de visao
                    [self listarAcoes];
                }
            }
        }
    }
    
    if ([self.acoes count]==0) {
        [self listarAcoes];
    }
}
-(void)inverterDirecao{
    if (self.dirCaminhada=='D') {
        self.dirCaminhada='E';
    }else{
        self.dirCaminhada='D';
    }
}

-(SEL)seletorProxAcao{
    return NSSelectorFromString([self.acoes firstObject]);
}

-(void)animarAnimal{
    if ([self.acaoAtual isEqualToString:@"andar"]) {
        
        [self.spriteAnimal runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAnimacao
                                                                                    timePerFrame:0.2f
                                                                                          resize:NO
                                                                                         restore:YES]] withKey:@"animandoAnimal"];
    }else if ([self.acaoAtual isEqualToString:@"fugindo"]){
        [self.spriteAnimal runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAnimacao
                                                                                    timePerFrame:0.2f
                                                                                          resize:NO
                                                                                         restore:YES]] withKey:@"animandoAnimal"];
        
    }else{
        [self.spriteAnimal runAction:[SKAction animateWithTextures:framesAnimacao
                                                      timePerFrame:0.2f
                                                            resize:NO
                                                           restore:YES] withKey:@"animandoAnimal"];
    }
}

-(void)listarAcoes{
    for (int i=0; i<self.nAcoesVez; i++) {
        float chanceAndar;
        
        //DECISAO DE andar LEVANDO EM CONSIDERAÇÃO A PERSONALIDADE
        if (self.personalidade == Agressivo) {
            chanceAndar=90;
        }else{
            chanceAndar=70;
        }
        
        //Sorteia se ataca ou se anda
        if ([DQUteis sortearChanceSim:chanceAndar]) {
            [self.acoes addObject:@"andar"];
        }else{
            [self.acoes addObject:@"parar"];
        }
    }
    
    if ([DQUteis sortearChanceSim:50.0f]) {
        [self.acoes addObject:@"inverterDirecao"];
    }
}

-(void)realizarAcao{
    if (![self.spriteAnimal hasActions]) {
        if ([self.acoes count]>0) {
            [self performSelector:[self seletorProxAcao]];
            [self.acoes removeObjectAtIndex:0];
        }else{
            [self rastrearAreaBackground:self.scene];
        }
    }
}

-(void)iniciarAnimacao:(NSString*)tipoAnimacao{
    SKTextureAtlas *pastaFrames= [SKTextureAtlas atlasNamed:self.nomeAnimal];
    
    framesAnimacao = [[NSMutableArray alloc]init];
    
    int nImagens=0;
    
    for (NSString *nomeTextura in [pastaFrames textureNames]) {
        if ([DQUteis string:nomeTextura contemPalavra:tipoAnimacao]) {
            nImagens++;
        }
    }
    
    NSString *textureName;
    
    for (int i=1; i <= nImagens; i++) {
        textureName = [NSString stringWithFormat:@"%@%d",tipoAnimacao, i];
        SKTexture *temp = [pastaFrames textureNamed:textureName];
        [framesAnimacao addObject:temp];
    }
}
-(void)fugir{
    //Remove as açoes do animal
    [self removeAllActions];
    
    //limpa a lista de acoes do animal
    [self.acoes removeAllObjects];
    
    //Inverte a direcao de caminhada
    if (self.dirCaminhada=='D') {
        self.dirCaminhada='E';
    }else{
        self.dirCaminhada='D';
    }
    
    [self andar];
}

-(void)parar{
    [self pararAnimacao];
}

-(BOOL)serCapturaChance:(float)chance :(DQIsca*)isca{
    if (self.personalidade == Docil) {
        chance+=5.0;
    }else if (self.personalidade == Agressivo){
        chance-=10.0;
    }
    
    if (([[self.objetoAtracao objeto]isEqualToString:isca.objeto])&&([[self.objetoAtracao detalhe]isEqualToString:isca.detalhe])) {
        chance+=30.0;
    }
    
    return [DQUteis sortearChanceSim:chance];
}

-(void)acaoAoColidirComJogador:(SKNode*)jogador{
    NSLog(@"colidiu com o jogador");
}
@end
