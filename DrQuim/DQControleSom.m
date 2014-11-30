//
//  DQControleSom.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 17/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//
#import "DQControleSom.h"

@implementation DQControleSom

-(id)initControleSom{
    if (self=[super init]) {
        //Faço a inicialização do players
        
        //No iOS temos como fazer com que uma classe receba notificações de outra classe sem ter um delegate
        //Para isso usamos o NSNotification,
        //Primeiro temos que avisar ao NSNotificationCenter (quem fica recebendo as msg das classes) que a nossa classe está esperando um tipo especifico de notificação (ex: SomNotification...)
        //Depois nas classes que queremos que se comuniquem com nossa classe inicial no precisamos postar uma notificaçao (ex: SomNotification) e o NSNotificationCenter irá ver que tem alguem esperando por essa notificação e vai chamar o método  especifico
        
        //Estou usando a variavel criada na DQUteis, para facilitar caso precisemos trocar os nomes e garantir que os nomes sejam iguais tanto quando postar a notificacao quanto cria-la
        
        //Jogador
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarSomJogador:) name:notificacaoJogadorPlaySom object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pararSomJogador) name:notificacaoJogadorStopSom object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarSomFalaJogador:) name:notificacaoJogadorFala object:nil];
        
        //Contador Gueiger
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarSomContadorGeiger:) name:notificacaoContadorPlaySom object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pararSomContador) name:notificacaoContadorStopSom object:nil];
        
        //NPC
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tocarSomNPC:) name:notificacaoNPCFalar object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pararSomNPC) name:notificacaoNPCParar object:nil];
        
        //Acessa o plist e pega as informações para os sons do jogador e de Fala dos NPCs,
        [self inializaDicionariosSons];
    }
    return self;
}

#pragma mark Config e Play nos players
-(void)tocarSomJogador:(NSNotification*)notification{
    //Paro qualquer som que já esteja tocando
    [self.playerSomJogador stop];
    
    //Recebemos a acao que o jogador esta realizando
    NSString *acaoJogador=[notification.userInfo valueForKey:@"acaoJogador"];
    
    //Recebemos o numero de loops na notification
    int nLoops=[[notification.userInfo valueForKey:@"nLoops"]intValue];
    
    //Definir o som a ser tocado
    NSString *somTocar=[self definirNomeSomJogadorAcao:acaoJogador];
    
    self.playerSomJogador=[self configuraPlayerSomUrlSom:[self urlParaSom:somTocar] nLoops:nLoops];
    [self.playerSomJogador play];
}

-(void)tocarSomContadorGeiger:(NSNotification*)notification{
    [self.playerContador stop];
    
    //Na notificação receberemos o nivel de perigo da radiação, depois definimos que som tocar e tocamos ele
    int nivelPerigo=[[notification.userInfo valueForKey:@"nivelPerigo"]intValue];
    
    NSString *nomeSomTocar=[NSString stringWithFormat:@"ContadorGeiger-%i.mp3",nivelPerigo];
    
    //Configuro o player e toco o som em looping
    self.playerContador=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeSomTocar] nLoops:-1];
    [self.playerContador play];
}

-(void)tocarSomFalaJogador:(NSNotification*)notification{
    //Recebo no dicionario da notificacao o nome do NPC e o tamanho da fala dele
    [self.playerSomJogador stop];
    
    //Mudanca no tamanho da fala agora iremos receber 0=Peq, 1=Media, 2=Grande assim facilita para localizar no Array :P
    int tamanhoFala=[[notification.userInfo valueForKey:@"tamanhoFala"]intValue];
    
    //Coloquei como array para diversificar os sons de falar
    NSArray *sonsFala=[[self.sonsDisponiveisJogador objectForKey:@"Falas"]objectAtIndex:tamanhoFala];
    
    //Sorteio entre os sons de fala disponíveis qual será tocado.
    NSString *nomeSomTocar=[sonsFala objectAtIndex:arc4random()%[sonsFala count]];
    
    //Configuro o player e toco o som em looping
    self.playerSomJogador=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeSomTocar] nLoops:0];
    
    [self.playerSomJogador play];
}

-(void)tocarSomNPC:(NSNotification*)notification{
    //Recebo no dicionario da notificacao o nome do NPC e o tamanho da fala dele
    [self.playerSomNPC stop];
    
    //Mudanca no tamanho da fala agora iremos receber 0=Peq, 1=Media, 2=Grande assim facilita para localizar no Array :P
    int tamanhoFala=[[notification.userInfo valueForKey:@"tamanhoFala"]intValue];
    NSString *nomeNPC=[notification.userInfo valueForKey:@"nomeNPC"];
    
    //Coloquei como array para diversificar os sons de falar
    NSArray *sonsFala=[[self.sonsDisponiveisNPC objectForKey:nomeNPC]objectAtIndex:tamanhoFala];
    
    //Sorteio entre os sons de fala disponíveis qual será tocado.
    NSString *nomeSomTocar=[sonsFala objectAtIndex:arc4random()%[sonsFala count]];
    
    //Configuro o player e toco o som em looping
    self.playerSomNPC=[self configuraPlayerSomUrlSom:[self urlParaSom:nomeSomTocar] nLoops:0];
    
    [self.playerSomNPC play];
}

#pragma mark STOP players
-(void)pararSomJogador{
    [self.playerSomJogador stop];
}

-(void)pararSomContador{
    [self.playerContador stop];
}

-(void)pararSomNPC{
    [self.playerSomNPC stop];
}
#pragma mark outros

//Metodo auxiliar que irá verificar qual ação o jogador esta realizando e definir qual som irá tocar
-(NSString*)definirNomeSomJogadorAcao:(NSString*)acaoRealizada{
    //Recebemos qual ação o jogador esta executando e verificamos no dicionario dele
    //Lembrar de colocar o nome da ação == ao nome do dicionario
    NSString *stringRetorno=[[self.sonsDisponiveisJogador objectForKey:@"Acoes"]objectForKey:acaoRealizada];
    
    return stringRetorno;
}
-(AVAudioPlayer*)configuraPlayerSomUrlSom:(NSURL*)urlSom nLoops:(int)nLoops{
    NSError *erro;
    AVAudioPlayer *player=[[AVAudioPlayer alloc]initWithContentsOfURL:urlSom error:&erro];
    
    [player setVolume:0.5f];
    [player setNumberOfLoops:nLoops];
    
    return player;
}
-(NSURL*)urlParaSom:(NSString*)nomeSom{
    return [[NSBundle mainBundle] URLForResource:nomeSom withExtension:@"mp3"];
}

-(void)inializaDicionariosSons{
    NSDictionary *dicConfigSom=[self arquivoPlist];
    
    self.sonsDisponiveisJogador=[dicConfigSom objectForKey:@"Jogador"];
    self.sonsDisponiveisNPC=[dicConfigSom objectForKey:@"NPC"];
}
-(NSDictionary*)arquivoPlist{
    //Verifica se tem fase configurada
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ConfigSons" ofType:@"plist"]];
}
@end
