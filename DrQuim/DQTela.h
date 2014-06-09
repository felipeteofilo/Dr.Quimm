//
//  DQTela.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 29/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQFala.h"

@interface DQTela : SKNode

//Imagem que aparecerá no fundo da Tela(Frame)
@property SKSpriteNode *imagemCena;

//Usado para guardar o array com as falas que apareceram na Tela(Frame)
@property NSMutableArray *falas;

//Indica que acabou as falas na Tela e pode passar para a prox cena.
@property BOOL fimFala;

//Método com retorno ID usado para inicializar a Tela
-(id)initTela: (SKSpriteNode*)_imagemTela idTela:(int)_idTela;

//Método comretorno VOID usado para exibir as falas
-(void)mostrarFala;


@end
