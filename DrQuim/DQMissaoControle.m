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
        
        //Define a próxima missão (a primeira)
        self.proximaMissao = 1;
        
        //Apresentando a próxima missão (no caso, a primeira)
        self.missao = [[DQMissao alloc] initMissao:self.proximaMissao];
    }
    return self;
}

-(BOOL)iniciarNovaMissaoNPC:(NSString*)NPC{
    if([self.missao podeIniciarComNPC:NPC]){
        self.emMissao = YES;
        return YES;
    }
    else{
        return NO;
    }
}


//TODO - AO INVÉZ DE UM ITEM PASSADO POR PARAMETRO, CONFERIR NO INVENTÁRIO
-(BOOL)passarParteMissao:(NSString*)NPC item:(NSString*)item{
    //Verifica se tem os pré-requisitos para passar de parte (dentro de uma missão)
    if([self.missao podePassarComNPC:NPC Item:item Parte:self.parteAtual]){
        [self entregarItem];
        [self receberItem];
        [self alterarEstados];
        
        //Verifica se essa foi a última parte...
        if(self.parteAtual+1 >= self.missao.quantidadeDePartes){
            [self fimDaMissao];
        }
        else{
            self.parteAtual++;
        }
        
        //retorna que a parte passou
        return YES;
    }
    else{
        //retorna que a parte não passou
        return NO;
    }
}

//TODO - COMUNICAÇÃO COM ITENS E INVENTÁRIO
//Método chamado quando a missão descreve que um item deve ser entregue
-(void)entregarItem{
    NSString *item = @"oi";
    NSLog(@"Item %@ entregue", item);
}

//TODO - COMUNICAÇÃO COM ITENS E INVENTÁRIO
//Método chamado quando a missão descreve que um item deve ser recebido
-(void)receberItem{
    NSString *item = @"oi";
    NSLog(@"Item %@ entregue", item);
    
}

//TODO - COMUNICAÇÃO COM OS ESTADOS DO JOGADOR
//Método chamado quando a missão descreve que os estados do jogador devem ser alterados
-(void)alterarEstados{
    
    
    NSLog(@"Alterando estados |Fome:%i Sede:%i Vida:%i |", 0, 0, 0);
}

//método chamado quando a missão chega ao fim
-(void)fimDaMissao{
    self.emMissao = NO;
    self.parteAtual = 0;
    self.proximaMissao++;
    self.missao = [[DQMissao alloc] initMissao:self.proximaMissao];
}
@end
