//
//  DQFala.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

//inicia o SKSpriteNode com seu tamanho e cor
-(id)initComDicionario: (NSDictionary *)dicionarioDaFala{
    if (self = [super initWithColor:[UIColor blackColor] size:CGSizeMake(self.scene.frame.size.width * 0.8, self.scene.frame.size.height * 0.25f)]) {
        //Verifica se tem foto

        
        
    }
    return self;
}

//cria a foto e o adiciona-a
-(void)criarFoto
{
    
}

//cria o texto e adiciona-o
-(void)criarTexto
{
    
}

//cria o aviso de "toque para continuar"
-(void)criarAviso
{
    
}

//Limita o texto de acordo com o tamanho da "caixa" que irá recebê-lo
-(void)configurarLimitesTexto
{
    
}


//...
//TEMPORÁRIO - APENAS PARA NÃO DAR ERRO
-(id)initComSujeito:sujeitoTemporario Texto:textoTemporario
{
    if (self = [super init]) {}
    return self;
}

@end
