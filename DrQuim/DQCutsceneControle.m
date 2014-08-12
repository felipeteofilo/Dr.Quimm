//
//  DQCutsceneControlle.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneControle.h"

@implementation DQCutsceneControle

-(id)initCutscene:(int)cutSceneAtual TamanhoTela:(CGSize)_tamanho{
    if (self=[super init]) {
        self.cenasCutScene=[self cenasCutScene:cutSceneAtual];
        self.cenaAtual=0;
        self.tamanhoTela=_tamanho;
    }
    return self;
}

-(SKSpriteNode*)montarCena{
    if ([self fimCutScene]) {
        return nil;
        
        NSLog(@"FIM DA CUTSCENE LEMBRE-SE DE VERIFICAR ANTES DE PEDIR PARA MONTAR CENA!");
    }else{
        NSDictionary *infoCena=[self infoCenaAtual];
        
        SKSpriteNode *cenaRetorno=[SKSpriteNode spriteNodeWithImageNamed:[infoCena objectForKey:@"Fundo"]];
        
        [cenaRetorno setAnchorPoint:CGPointMake(0, 0)];
        
        //Verifica se tem fala para ser dita na cena
        NSString *testeSujeitoCena=[infoCena objectForKey:@"Sujeito"];
        if (![testeSujeitoCena length]==0) {
            DQFala *falaCena=[[DQFala alloc]initComDicionario:infoCena eTamanho:self.tamanhoTela];
            
            [cenaRetorno addChild:falaCena];
            [falaCena setAnchorPoint:CGPointMake(0, 0)];
            [falaCena setPosition:CGPointMake(cenaRetorno.frame.size.width*0.1, CGRectGetMinY(cenaRetorno.frame)+20)];
        }

        [self atualizaCenaAtual];
        return cenaRetorno;
    }
}

-(void)atualizaCenaAtual{
    self.cenaAtual++;
}

-(BOOL)fimCutScene{
    if (self.cenaAtual == [self.cenasCutScene count]) {
        return YES;
    }else{
        return NO;
    }
}

-(NSArray*)arquivoPlist{
    //Acessa o arquivo plist e retorna o array com o
    NSArray *arrayRetorno=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"FalasCutScene" ofType:@"plist"]];
    
    return arrayRetorno;
}

-(NSArray*)cenasCutScene:(int)cutSceneAtual{
    NSArray *arrayRetorno=[[self arquivoPlist]objectAtIndex:cutSceneAtual];
    
    return arrayRetorno;
}

-(NSDictionary*)infoCenaAtual{
    return [self.cenasCutScene objectAtIndex:self.cenaAtual];
}
@end