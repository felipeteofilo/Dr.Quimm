//
//  DQFala.h
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQTexto.h"
#import "DQControleSom.h"

@interface DQFala : SKSpriteNode

//Variáveis auxiliares do dicionário
@property NSString *sujeito;
@property NSString *texto;
@property NSString *foto;

//Variáveis de tamanho do texto
@property CGSize tamanhoTextoComFoto;
@property CGSize tamanhoTextoSemFoto;
@property CGSize tamanhoTexto;

//Variáveis de posição do texto
@property CGSize posicaoTextoComFoto;
@property CGSize posicaoTextoSemFoto;
@property CGSize posicaoTexto;

//Adicionado o DQTexto nas propriedades para poder manipulá-lo futuramente
@property DQTexto *textoConfigurado;


//Método de início - recebe o dicionário da fala e o tamanho da cena a quem pertence
-(id)initComDicionario: (NSDictionary *)dicionarioDaFala eTamanho:(CGSize)tamanho;

//TEMPORÁRIO - APENAS PARA NÃO DAR ERRO
-(id)initComSujeito:sujeitoTemporario Texto:textoTemporario;

-(TamanhoTexto)tamanhoTexo;
@end
