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
    NSLog(@"passou pelo tocar som puro");
     [self tocarSom:[self configuraPlayerSom:[self.listaSons objectAtIndex:self.indiceSomTocar]]];
}

//-(void)tocarSom:(NSString*)nomeSomTocar{
-(void)tocarSom:(AVAudioPlayer*)player{
    SKAction *playAction = [SKAction runBlock:^{
        [player play];
    }];

    
    SKAction *waitAction = [SKAction waitForDuration:player.duration+1];
    SKAction *sequence = [SKAction sequence:@[playAction, waitAction]];
    
    [self runAction:sequence withKey:@"tocandoSom"];

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

//Passa o nome do objeto que recebera o controle de som para configurar os sons especificos
-(id)initControleSom:(TipoObjeto)objetoControlado;{
    if (self=[super init]) {
        self.indiceSomTocar=0;
        
//        if (![nomeObjetoControlado isEqualToString:@"contador"]) {
//            [self configurarListaSons];
//        }
    }
    return self;
}

-(void)configurarListaSons{
    
}

-(void)pararSom{
    [self removeAllActions];
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
