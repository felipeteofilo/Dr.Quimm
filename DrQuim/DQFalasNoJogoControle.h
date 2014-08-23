//
//  DQFalasNoJogoControle.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQControleSom.h"
#import "DQFala.h"

@interface DQFalasNoJogoControle : NSObject

@property DQFala * caixaDeFala;


//Varialvel do tipo NSMutableDicionary que guarda o dicionario de fals da missao atual
@property NSMutableDictionary *dicionarioDeFalas;

//Varialvel do tipo NSArray que guarda as falas atuais
@property NSArray * arrayDeFalasAtuais;

//Varialvel do tipo int que define a fala atual
@property int falaAtual;

//Variavel do tipo NSString que define se esta passando alerta ou fala de jogo
@property NSString *estadoFala;

@property DQControleSom *controleSom;

//Iniciar com a fase atual
-(id)initComFaseAtual:(int)faseAtual;

//Mostrar Algum alerta da fase passando a key do alerta
-(SKSpriteNode*)mostrarAlertaComKey :(NSString*)key Tamanho:(CGSize)tamanho;

//Mostrar fala em uma missao ou nao, passando o nome do Npc e a key da fala, e se estiver em missao a missao atual
-(SKSpriteNode*)mostrarFalaComNPC :(NSString*)npc KeyDaFala:(NSString*)keyFala Missao:(NSString*)missao Tamanho:(CGSize)tamanho;

//Metodo que retorna se pode ou nao mostrar a proxima fala
-(Boolean)proximaFala;


@end
