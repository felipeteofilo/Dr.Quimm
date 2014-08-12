//
//  DQnpc.h
//  DrQuim
//
//  Created by Julia Yamamoto on 08/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQnpc : SKSpriteNode

//NSString que armazena o nome do NPC
@property NSString *nome;

//Método INIT que inicia o NPC com o nome dele e a posicao
-(id)initComNome:(NSString *)nome naPosicao:(CGPoint)posicao;




@end
