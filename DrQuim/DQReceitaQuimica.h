//
//  DQReceitaQuimica.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQReceitaQuimica : SKSpriteNode

//NSDictionary que guarda as informações da missão
@property NSDictionary *dicionarioDaMissao;

//Sprites que armazenam os ingredientes
@property SKLabelNode *labelIngrediente1;
@property SKLabelNode *labelIngrediente2;

//Sprites que armazenam a caixa de "check"para cada ingrediente
@property SKSpriteNode *spriteConfirmacao1;
@property SKSpriteNode *spriteConfirmacao2;

//Booleanos que indicam se os ingredientes estão confirmados ou não
@property BOOL ingredienteConfirmado1;
@property BOOL ingredienteConfirmado2;

//Método INIT que recebe o dicionario da receita atual e o tamanho da maleta
-(id)initComDicionarioDaReceita: (NSDictionary *)receita eTamanho:(CGSize)tamanhoMaleta;

//Método chamado para alterar o sinal de OK(numero indicado pelo ingrediente) para aparecer
-(void)confirmaIngrediente: (int)ingrediente;

//Método chamado para alterar o sinal de OK(numero indicado pelo ingrediente) para desaparecer
-(void)desconfirmaIngrediente: (int)ingrediente;


@end
