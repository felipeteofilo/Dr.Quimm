//
//  DQControleSomScene.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//
#import "DQControleSomScene.h"

@implementation DQControleSomScene

-(id)initControleSomCena{
    if (self=[super init]) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarMusicaCena:) name:notificacaoMusicaFundo object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pararMusicaFundo) name:notificacaoMusicaFundoParar object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarEfeitoCena:) name:notificacaoFaseEfeito object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarSomAnimal:) name:notificacaoAnimal object:nil];
        
        //Essa notificacao será usada para definir se estamos lidando com uma fase ou uma cutScene
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(defineTipoScene:) name:notificacaoTipoScene object:nil];
    }
    return self;
}


#pragma mark Play sons
-(void)tocarEfeitoCena:(NSNotification*)notificacao{
    [self.playerEfeitoCena stop];
    
    int idEfeito =[[notificacao.userInfo objectForKey:@"idEfeitoCena"]intValue];
    
    NSString *nomeEfeito= [[self.sonsDisponiveisScene objectForKey:@"Efeitos"]objectAtIndex:idEfeito];
    
    self.playerEfeitoCena=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeEfeito] nLoops:0];
    [self.playerEfeitoCena play];
}
-(void)tocarMusicaCena:(NSNotification*)notificacao{
    [self.playerMusicaFundo stop];
    
    int indiceMusica=[[notificacao.userInfo objectForKey:@"idMusicaCena"]intValue];
    NSString *nomeMusica=[[self.sonsDisponiveisScene objectForKey:@"Musicas"]objectAtIndex:indiceMusica];
    
    self.playerMusicaFundo=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeMusica] nLoops:-1];
    
    [self tocarMusicaFundo];
}
-(void)tocarSomAnimal:(NSNotification*)notificacao{
    //Para o animal receberemos o nome dele e como convencao colocamos o nome do arquivo de som igual ao nome do animal
    [self.playerAnimal stop];
    
    NSString *nomeAnimal =[notificacao.userInfo objectForKey:@"nomeAnimal"];
    
    self.playerAnimal=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeAnimal] nLoops:0];
    [self.playerAnimal play];
}

#pragma mark Stop sons
-(void)pararMusicaFundo{
    [self.playerMusicaFundo stop];
}

#pragma mark Outros
//Sempre chamar esse metodo qndo a cena for ser exibida pls
-(void)defineTipoScene:(NSNotification*)notificacao{
    //Precisarei receber o tipo da Scene (cutScene ou Fase) e o ID dela
    //Usar como padrao int=0 para Fase e int=1 para CutScene
    self.tipoCena=[[notificacao.userInfo objectForKey:@"tipoFase"]intValue];
    self.indiceCena=[[notificacao.userInfo objectForKey:@"idFase"]intValue]-1; // -1 usado para ajustar o ID da fase com a pos no array
    
    //Agora que sabemos com oq estamos lidando iniciamos o dicionario
    [self inicializaDicSonsScene];
}

-(void)inicializaDicSonsScene{
    
    //Verifico se estou lidando com fase ou cutScene
    if (self.tipoCena==Fase) {
        self.sonsDisponiveisScene=[[[self arquivoPlist]objectForKey:@"Fases"]objectAtIndex:self.indiceCena];
    }else if(self.tipoCena==CutScene){
        self.sonsDisponiveisScene=[[[self arquivoPlist]objectForKey:@"CutScene"]objectAtIndex:self.indiceCena];
    }
}
-(void)pararSomEfeito{
    [self.playerEfeitoCena stop];
}
-(void)tocarMusicaFundo{
    if (self.playerMusicaFundo) {
        [self.playerMusicaFundo play];
    }
}

@end
