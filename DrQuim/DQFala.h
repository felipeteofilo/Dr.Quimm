//
//  DQFala.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//Enum Balão - Define os Balões que serão usados
enum Balao
{
    balaoFala,
    balaoPensamento,
    balaoGrito
};
typedef enum Balao Balao;
//fim

//Enum Emoticon - Define os Emoticons que serão usados
enum Emoticon
{
    emoticonEnvergonhado,
    emoticonIndiferente,
    emoticonAnimado,
    emoticonRisadaIronica,
    emoticonFeliz,
    emoticonAssustado,
    emoticonDor,
    emoticonIrritado,
    emoticonInteligente,
    emoticonSuspirando,
    emoticonConfuso
};
typedef enum Emoticon Emoticon;
//fim


@interface DQFala : SKSpriteNode

//Variável Enum Emoticon - Define qual e se terá emoticon a ser exibido antes da fala
@property Emoticon tipoEmoticon;

//Variável UIImage imagemEmoticon - Define qual a imagem do emoticon a partir da informação passada
@property UIImage *imagemEmoticon;

//Variável Enum Balão - Define o tipo de balão que irá aparecer na tela
@property Balao tipoBalao;

//Variável NSString - Define o texto que será exibido no balão
@property NSString *texto;

//Método de INIT - Passa o texto, posicão do texto e tipo de balão
-(id)initFala: (NSString*)_texto :(CGPoint)_posicao :(Balao)_balao;

//A FAZER
//Método de INIT - Passa o texto, posicão do texto, tipo de balão e tipo de emoticon
-(id)initFala: (NSString*)_texto :(CGPoint)_posicao :(Balao)_balao :(Emoticon)_emoticon;

@end
