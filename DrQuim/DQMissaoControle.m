//
//  DQMissaoControle.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissaoControle.h"

@implementation DQMissaoControle

-(id)initCena:(SKScene*)cenaRecebida{
    if (self=[super init]) {
        //Atribui a cena recebida por parâmetro á cena em que a Missao está acontecendo
        self.cena = cenaRecebida;
        
        //Inicia na parte 0
        self.parteAtual = 0;
        
        //E sem nenhuma missão
        self.emMissao = NO;
        
        //Apresentando a próxima missão (no caso, a primeira)
        self.missao = [[DQMissao alloc] initMissao:1];
    }
    return self;
}

-(BOOL)iniciarNovaMissaoNPC:(NSString*)NPC{
    
    
    
    return NO;
}

-(BOOL)passarParteMissao:(NSString*)NPC item:(NSString*)item{
    
    
    
    
    return NO;
}

//FAZER - COMUNICAÇÃO COM ITENS E INVENTÁRIO
//Método chamado quando a missão descreve que um item deve ser entregue
-(void)entregarItem{
    NSString *item = @"oi";
    NSLog(@"Item %@ entregue", item);
    
    
    
}

//FAZER - COMUNICAÇÃO COM ITENS E INVENTÁRIO
//Método chamado quando a missão descreve que um item deve ser recebido
-(void)receberItem{
    NSString *item = @"oi";
    NSLog(@"Item %@ entregue", item);
    
}

//FAZER - COMUNICAÇÃO COM OS ESTADOS DO JOGADOR
//Método chamado quando a missão descreve que os estados do jogador devem ser alterados
-(void)receberEstados{
    
}

//método chamado quando a missão chega ao fim
-(void)fimDaMissao{
    
}
@end
