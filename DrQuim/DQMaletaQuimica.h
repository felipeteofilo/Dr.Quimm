//
//  DQMaletaQuimica.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQAmostraQuimica.h"
#import "DQReceitaQuimica.h"

@interface DQMaletaQuimica : SKSpriteNode


//AMOSTRAS
    //NSArray que armazena as instâncias de DQAmostrasQuimicas
    @property NSMutableArray *arrayDeAmostras;

    //NSArray que armazena as informações da plist AmostrasQuimicas
    @property NSArray *arrayDeReferenciaDeAmostras; //plist
//...............


//RECEITA
    //DQReceitaQuimica da receita atual
    @property DQReceitaQuimica *receitaAtual;

    //NSDictionary que armazena o dicionário da receita atual, passado no INIT
    @property NSDictionary *dicionarioReceita;
//...............


//INSTRUÇÕES
    @property SKLabelNode *labelInstrucao1; //"Selecione os"
    @property SKLabelNode *labelInstrucao2; //"Ingredientes"
//...............


//Método INIT que recebe o tamanho da cena que o chama e o dicionario que indica a receita atual
-(id)initComTamanho: (CGSize)tamanho eDicionarioDaReceita:(NSDictionary *)receita;


@end
