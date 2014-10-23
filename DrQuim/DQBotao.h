//
//  RTBotao.h
//  Robotunes
//
//  Created by LEONARDO DE SOUSA MENDES on 29/09/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQControleProtocoll.h"

@interface DQBotao : SKSpriteNode

@property SEL acaoRealizar;
@property id<DQControleProtocoll> delegateBotao;
@property NSString *atlasAnimacao;

-(id)initBotao:(NSString*)atlasAnimacao comSel:(SEL)seletor eDelegate:(id<DQControleProtocoll>)delegate eTamanho:(CGSize)size;
@end
