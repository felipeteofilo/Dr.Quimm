//
//  DQUteis.h
//  Contador
//
//  Created by LEONARDO DE SOUSA MENDES on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

//Leonardo, alterado pois agora cada objeto do jogo definirá sua bitMask
//define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 0;
static const UInt32 ChaoCategoria = 0x1 << 1;
static const UInt32 PlataformaAtivadaCategoria = 0x1 << 2;
static const UInt32 PlataformaDesativadaCategoria = 0x1 << 3;
static const UInt32 EscadaCategoria = 0x1 << 4;


static  NSString *notificacaoJogadorPlaySom =@"somNotificationJogadorPlay";
static  NSString *notificacaoJogadorStopSom =@"somNotificationJogadorStop";
static  NSString *notificacaoJogadorFala=@"somNotificationJogadorFala";

static  NSString *notificacaoMusicaFundo =@"somNotificationMusicaFundo";
static  NSString *notificacaoMusicaFundoParar =@"somNotificationMusicaFundoStop";
static  NSString *notificacaoFaseEfeito =@"somNotificationEfeito";
static  NSString *notificacaoTipoScene=@"somNotificationDefTipoScene";

static  NSString *notificacaoContadorPlaySom =@"somNotificationContadorPlay";
static  NSString *notificacaoContadorStopSom =@"somNotificationContadorStop";

static  NSString *notificacaoNPCFalar =@"somNotificationNPCFalar";
static  NSString *notificacaoNPCParar =@"somNotificationNPCPararFalar";
static  NSString *notificacaoAnimal =@"somNotificationAnimal";

static NSString *notificacaoFruta =@"notificarionAddFruta";

@interface DQUteis : NSObject


+(BOOL)string:(NSString*)strTestar contemPalavra:(NSString*)palavraProcurada;
+(float)calcularDistanciaPontos:(CGPoint)primeiroPonto ponto2:(CGPoint)segundoPonto;
+(NSMutableArray*)ordenarValores:(NSMutableArray*)array;
+(BOOL)sortearChanceSim:(float)chanceSim;
+(BOOL)array:(NSArray*)array contemString:(NSString*)stringTestar;

@end
