//
//  DQTransformacaoTela.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQAmostraQuimica.h"
#import "DQMaletaQuimica.h"
#import "DQTransformacaoControle.h"

@interface DQTransformacaoTela : SKScene

//DQTransformacaoMatela que armazena uma referencia á classe de controle das transformações
@property DQTransformacaoControle *transformacaoControle;

//DQMaletaQuimica que armazena a maleta e todas as amostras e as mostra na tela
@property DQMaletaQuimica *maletaQuimica;

//SPRITES DAS AMOSTRAS
@property DQAmostraQuimica *amostra1;
@property DQAmostraQuimica *amostra2;

//NOMES DAS AMOSTRAS
@property NSString *nomeAmostra1;
@property NSString *nomeAmostra2;

//booleanos que dizem se as amostras importantes á receita estão selecionadas ou não - TELA DE SELEÇÃO
@property BOOL amostra1Selecionada;
@property BOOL amostra2Selecionada;

//*************
//receitas
@property NSString *urlReceitas;
@property NSArray *arrayReceitas;
//*************


//*************
//NSArray que armazena os NSStrings dos elementos
@property NSArray *arrayDeElementosAmostra1;
@property NSArray *arrayDeElementosAmostra2;

//NSMutableArray que armazena os SKSpriteNodes dos elementos
@property NSArray *arrayDeSpritesDeElementosAmostra1;
@property NSArray *arrayDeSpritesDeElementosAmostra2;

//SKSpriteNode que armazena qual o node que foi selecionado e irá se mover
@property SKNode *nodeTocado;
@property CGPoint posicaoInicial;
@property CGPoint posicaoDelta;

//NSMutableArray que armazena todos os nodesDestinos
@property NSMutableArray *arrayDeSpritesDestino;
//*************





//NSDictionary da receita atual
@property NSDictionary *dicionarioReceitaAtual;

//Boleano que armazena se está ou não mostrando a tela de selecao
@property BOOL mostrandoTelaDeSelecao;

//Método que mostra a tela de transformação
-(void)mostrarTelaTransformacao;

@end
