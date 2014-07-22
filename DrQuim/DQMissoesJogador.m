//
//  DQMissoesJogador.m
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissoesJogador.h"

@implementation DQMissoesJogador

-(id)init
{
    self = [super init];
    if(self){
        
        //Popula o dicionario de Missoes do jogador
        //url
        NSString *urlMissoesJogador = [[NSBundle mainBundle] pathForResource:@"MissoesJogador" ofType:@"plist"];
        //dicionario
        self.arrayDeMissoesJogador = [[NSMutableArray alloc]initWithContentsOfFile:urlMissoesJogador];
        
        
        //Popula o dicionario que descreve as Missões
        //url
        NSString *urlMissoesReferencia = [[NSBundle mainBundle] pathForResource:@"MissoesReferencia" ofType:@"plist"];
        //dicionario
        self.arrayDeMissoesReferencia = [[NSMutableArray alloc]initWithContentsOfFile:urlMissoesReferencia];
        
        
        //Key da missão atual - inicia na 0 que é sem missão
        self.missaoAtual = 0;
        
        //Inicia no 0
        self.parteDaMissao = 0;
        

        //TESTE
        //mostra as informações da missão atual
        [self mostrarMissao];
        
        //muda de missão - Para a missão01: Ajudando a mãe de todos
        [self iniciarMissao:1];
        [self mostrarMissao];
        
        //passa de parte - 0 para 1
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 1 para 2
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 2 para 3
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 3 para 4
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 4 para 5
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 5 para 6
        [self passarParteMissao];
        [self mostrarMissao];
        
        //passa de parte - 6 para 7
        [self passarParteMissao];
        [self mostrarMissao];
        
        //tenta passar de parte - 7 para 8 - percebe que acabou e volta para o índice 0 <sem missão>
        [self passarParteMissao];
        [self mostrarMissao];
        //FIM TESTE
        
    }
    return self;
}

-(void)iniciarMissao: (int)missao
{
    //Coloca o valor "Atual" da "self.missaoAtual" como NO
    [[self.arrayDeMissoesJogador objectAtIndex:self.missaoAtual] setValue:[NSNumber numberWithBool:NO] forKey:@"Atual"];
    
    //Coloca o valor "Atual" da "missao" como YES
    [[self.arrayDeMissoesJogador objectAtIndex:missao] setValue:[NSNumber numberWithBool:YES] forKey:@"Atual"];
    
    //Redefine variaveis da missão
    //missão atual será a missaão passada por parâmetro
    self.missaoAtual = missao;
    
    //missão começa na parte 0
    self.parteDaMissao = 0;
}

-(void)passarParteMissao
{
    //Se estiver na última parte da missão, vai para o fim da missão e recebe o que precisa receber
    if(self.parteDaMissao == [[[self.arrayDeMissoesJogador objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] intValue]-1){
        [self fimDaMissao];
    }
    //senão, só passa de parte
    else{
        self.parteDaMissao++;
    }
   
}

-(void)fimDaMissao
{
    //Termina a missão - recebe os itens especificados nela
    NSLog(@" ");
    NSLog(@"FIM DA MISSÃO - Fazer receber itens!");
    
    //volta para a missão0, ou seja, volta a não estar em nenhuma missão.
    [self iniciarMissao:0];
}

-(void)mostrarMissao
{
    //nome
    NSString *nomeTemporario = [[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Nome"];
    
    //recompensa
    NSString *recompendaTemporaria = [[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Recompensa"];
    
    //respeito recebido
    int respeitoGeralTemporario = [[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Respeito"] intValue];
    
    //partes
        //Descrição
        NSString *descricaoTemporaria = [[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Descricao"];
    
        //Objetivo atual
        NSString *objetivoAtualTemporario = [[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Objetivo Atual"];
    
        //Item recebido
        NSString *itemRecebidoTemporario = [[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Item Recebido"];
    
        //Item entregue
        NSString *itemEntregueTemporario = [[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Item Entregue"];
    
        //Fome recebido
        int fomeTemporaria = [[[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Fome"] intValue];
    
        //Sede recebido
        int sedeTemporaria = [[[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Sede"] intValue];
    
        //Respeito recebido
        int repeitoTemporario = [[[[[self.arrayDeMissoesReferencia objectAtIndex:self.missaoAtual] objectForKey:@"Partes"] objectAtIndex:self.parteDaMissao] objectForKey:@"Respeito"] intValue];
    
    //Mostrando coisas da missão geral
    NSLog(@"Nome da Missão: %@| Recompensa: %@| RespeitoGeral: %i", nomeTemporario, recompendaTemporaria, respeitoGeralTemporario);
    
    //Mostrando coisas da parte atual da missão
    NSLog(@"Parte atual: %i| Descrição: %@| Objetivo atual: %@| Item recebido: %@| Item entregue: %@| Fome: %i| Sede: %i| Respeito: %i", self.parteDaMissao, descricaoTemporaria, objetivoAtualTemporario, itemRecebidoTemporario, itemEntregueTemporario,fomeTemporaria, sedeTemporaria, repeitoTemporario);
    
    NSLog(@" ");
}

@end
