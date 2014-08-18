//
//  DQControleSomScene.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleSomScene.h"

@implementation DQControleSomScene

-(id)initControleSomScene:(TipoCena)tipoCena indiceCena:(int)idCena{
    if (self=[super init]) {
        self.tipoCenaConfigurado =tipoCena;
        self.indiceScene=idCena;
    }
    return self;
}

-(AVAudioPlayer*)configuraMusicaFundo:(NSString*)nomeSomTocar{
    NSError *error;
    
    NSURL *urlSom = [[NSBundle mainBundle] URLForResource:nomeSomTocar withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSom error:&error];
    
    [player setVolume:[DQControleUserDefalts volumeMusica]];
    [player setNumberOfLoops:-1];
    [player prepareToPlay];
    
    return player;
}

-(void)tocarSom:(AVAudioPlayer *)player{
    [super tocarSom:[self configuraMusicaFundo:self.musicaFundo]];
}

-(NSString*)nomeSonsFundoFase{
    NSString *stringRetorno;
    
    if (self.tipoCenaConfigurado==Fase) {
        //Acessa config fase
        stringRetorno=[DQConfiguracaoFase somFundoFase:self.indiceScene];
    }else{
        //Acessa config CutScene
        
    }

    return stringRetorno;
}
@end
