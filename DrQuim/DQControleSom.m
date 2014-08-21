//
//  DQControleSom.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 17/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//
#import "DQControleSom.h"

@implementation DQControleSom

-(void)tocarSom{
    [self tocarSom:[self configuraPlayerSom:[self.listaSons objectAtIndex:self.indiceSomTocar]]];
}

-(void)tocarSomAleatorio{
    
}
-(void)tocarSom:(AVAudioPlayer*)player{
    SKAction *playAction = [SKAction runBlock:^{
        [player play];
    }];
    
    //Faz com que a execução das actions atrasem p dar tempo de sair o som
    SKAction *waitAction = [SKAction waitForDuration:player.duration];
    
    //Chama o play e o atraso
    SKAction *sequence = [SKAction sequence:@[playAction,waitAction]];

    [self runAction:sequence completion:^{
        [self removeAllActions];
    }];
}

-(void)tocarSomLooping:(AVAudioPlayer*)player{
    SKAction *playAction = [SKAction runBlock:^{
        [player play];
    }];
    
    //Faz com que a execução das actions atrasem p dar tempo de sair o som
    SKAction *waitAction = [SKAction waitForDuration:player.duration];
    
    //Chama o play e o atraso
    SKAction *sequence = [SKAction sequence:@[playAction,waitAction]];

    [self runAction:sequence withKey:@"tocandoSom"];
}

-(void)pararSom{
    [self removeAllActions];
}

-(AVAudioPlayer*)configuraPlayerSom:(NSString*)nomeSomTocar{
    NSError *error;
    NSURL *urlSom = [[NSBundle mainBundle] URLForResource:nomeSomTocar withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSom error:&error];
    
    [player setVolume:[DQControleUserDefalts volumeSons]];
    [player prepareToPlay];
    [player setNumberOfLoops:0];
    
    return player;
}

-(AVAudioPlayer*)configuraPlayerSom:(NSString*)nomeSomTocar nLoops:(int)nLoops{
    NSError *error;
    NSURL *urlSom = [[NSBundle mainBundle] URLForResource:nomeSomTocar withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSom error:&error];
    
    [player setVolume:[DQControleUserDefalts volumeSons]];
    [player prepareToPlay];
    [player setNumberOfLoops:nLoops];
    
    return player;
}
//Passa o nome do objeto que recebera o controle de som para configurar os sons especificos
-(id)initControleSom:(TipoObjeto)objetoControlado;{
    if (self=[super init]) {
        self.indiceSomTocar=0;
        self.tipoObjeto=objetoControlado;
    }
    return self;
}

-(void)configurarListaSons{
    if (self.tipoObjeto==NPC || self.tipoObjeto==Jogador) {
        NSArray *sonsdisponiveis=[NSArray arrayWithObjects:@"FalaPersonagens-Pequena-1",@"FalaPersonagens-Pequena-2",@"FalaPersonagens-Grande-1",@"FalaPersonagens-Media-1",@"FalaPersonagens-Media-2", nil];
        
        NSMutableArray *arraySons=[NSMutableArray array];
        
        int valorSorteado;
        
        for (int i=0; i<3; i++) {
            valorSorteado=arc4random()%[sonsdisponiveis count]-1;
            [arraySons addObject:[sonsdisponiveis objectAtIndex:valorSorteado]];
        }
        
        self.listaSons=arraySons;
    }
}

-(NSString*)somFala:(TamanhoTexto)tamanhoFala{
    NSArray *sonsDisponiveis;
    
    if (tamanhoFala==Pequeno) {
        sonsDisponiveis=[NSArray arrayWithObjects:@"FalaPersonagens-Pequena-1",@"FalaPersonagens-Pequena-2",nil];
    }else if (tamanhoFala==Medio){
        sonsDisponiveis=[NSArray arrayWithObjects:@"FalaPersonagens-Media-1",@"FalaPersonagens-Media-2",nil];
    }else{
        sonsDisponiveis=[NSArray arrayWithObjects:@"FalaPersonagens-Grande-1",@"FalaPersonagens-Grande-2",nil];
    }
    
    int valorSorteado=(arc4random()%[sonsDisponiveis count]);
    
    return [sonsDisponiveis objectAtIndex:valorSorteado];
}


-(void)proxSom{
    if (self.indiceSomTocar < ([self.listaSons count]-1)) {
        self.indiceSomTocar ++;
    }else{
        self.indiceSomTocar=0;
    }
}

-(void)tocarSomLista{
    [self tocarSom:[self configuraPlayerSom:[self.listaSons objectAtIndex:self.indiceSomTocar]]];
    
    [self proxSom];
}

-(int)sortearSomTocar{
    return arc4random()%[self.listaSons count];
}
@end
