//
//  DQnpc.h
//  DrQuim
//
//  Created by Julia Yamamoto on 08/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQnpc : SKNode

//SKSpriteNode do NPC
@property SKSpriteNode *spriteNode;

//NSString que armazena o nome do NPC
@property NSString *nome;

//NSDictionary que armazena as falas do NPC atual
<<<<<<< HEAD
@property NSDictionary *dicionarioDeFalas;

//NSDictionary que armazena as falas do NPC atual - QUANDO SEM MISSÃO
@property NSDictionary *dicionarioDeFalasSemMissao;

//NSDictionary que armazena as falas do NPC atual - QUANDO NA MISSÃO1
@property NSDictionary *dicionarioDeFalasMissao01;
=======
@property NSDictionary *dicionarioDeFalasDoNPC;
>>>>>>> FETCH_HEAD

//Método INIT que inicia o NPC com o nome dele
-(id)initComNome: (NSString *)nome;

<<<<<<< HEAD
//Método que faz com que o NPC diga suas falas - Baseadas no respeito
-(void)interagirSemMissao: (int)respeito;
=======
//Método que faz com que o NPC diga suas falas
-(void)interagir;
>>>>>>> FETCH_HEAD

//Método que cria o SpriteNode do SKNode em questão
-(void)criarSpriteNodeComNome:(NSString*)nome naPosicao:(CGPoint)posicao;


@end
