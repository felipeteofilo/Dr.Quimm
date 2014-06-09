//
//  DQFala.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

@synthesize texto;

//METODO INIT - SEM Emoticon
-(id)initFala: (NSString*)_texto :(CGPoint)_posicao :(Balao)_balao{
    
    //Define a imagem do balão baseando-se na informação passada
    self.tipoBalao = _balao;
    switch (_balao) {
        case balaoFala:
            self = [super initWithImageNamed:@"balaoFala"];
            break;
        case balaoGrito:
            self = [super initWithImageNamed:@"balaoGrito"];
            break;
        case balaoPensamento:
            self = [super initWithImageNamed:@"balaoPensamento"];
        default:
            break;
    }
    //fim
    
    if (self){
        self.texto=_texto;
        self.position=_posicao;
    }
    return self;
}

//METODO INIT - COM Emoticon (A FAZER! - COLOCAR IMAGENS EMOTICONS)
-(id)initFala: (NSString*)_texto :(CGPoint)_posicao :(Balao)_balao :(Emoticon)_emoticon{
    
    //Define a imagem do balão baseando-se na informação passada
    self.tipoBalao = _balao;
    switch (_balao) {
        case balaoFala:
            self = [super initWithImageNamed:@"balaoFala"];
            break;
        case balaoGrito:
            self = [super initWithImageNamed:@"balaoGrito"];
            break;
        case balaoPensamento:
            self = [super initWithImageNamed:@"balaoPensamento"];
        default:
            break;
    }
    //fim
    
    if (self){
        
        //Define a imagem do emoticon baseando-se na informação passada
        switch (_emoticon) {
            case emoticonAnimado:
                self.imagemEmoticon = [UIImage imageNamed:@"Animado"];
                break;
            case emoticonAssustado:
                self.imagemEmoticon = [UIImage imageNamed:@"Assustado"];
                break;
            case emoticonConfuso:
                self.imagemEmoticon = [UIImage imageNamed:@"Confuso"];
                break;
            case emoticonDor:
                self.imagemEmoticon = [UIImage imageNamed:@"Dor"];
                break;
            case emoticonEnvergonhado:
                self.imagemEmoticon = [UIImage imageNamed:@"Envergonhado"];
                break;
            case emoticonFeliz:
                self.imagemEmoticon = [UIImage imageNamed:@"Feliz"];
                break;
            case emoticonIndiferente:
                self.imagemEmoticon = [UIImage imageNamed:@"Indiferente"];
                break;
            case emoticonInteligente:
                self.imagemEmoticon = [UIImage imageNamed:@"Inteligente"];
                break;
            case emoticonIrritado:
                self.imagemEmoticon = [UIImage imageNamed:@"Irritado"];
                break;
            case emoticonRisadaIronica:
                self.imagemEmoticon = [UIImage imageNamed:@"RisadaIronica"];
                break;
            case emoticonSuspirando:
                self.imagemEmoticon = [UIImage imageNamed:@"Suspirando"];
                break;
            default:
                break;
        }
        //fim
        
        self.tipoEmoticon = _emoticon;
        self.texto = _texto;
        self.position = _posicao;
    }
    return self;
}

@end
