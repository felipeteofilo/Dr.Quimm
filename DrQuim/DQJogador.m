//
//  DQJogador.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQJogador.h"

@implementation DQJogador

//Leonardo 13/06/2014 - Alterado a função de inicialização do node para que carregue o sprite na propriedade spriteNode
//Funcao para iniciar e alocar tudo que for necessario para o player
-(id)initJogadorSprite: (NSString*)name{
    
    if(self = [super init]){
        
        //Leonardo 13/06/2014 - Inicia o sprite
        self.spriteNode=[SKSpriteNode spriteNodeWithImageNamed:name];
        
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        [self.spriteNode setSize:CGSizeMake(90, 160)];
        
        [self.spriteNode setZPosition:100.0f];
        
        //Deixar o corpo fisico mais prox ao sprite
        [self configuraCorpoFisico];
        [self addChild:self.spriteNode];
        
        //Seta que ele ainda nao pode escalar
        self.podeEscalar = NO;
        self.estaNoChao = YES;
        //USADO COMO TESTE
        self.fome = 100;
        self.sede = 100;
        self.vida = 100;
        self.respeito = 0;
        
        
        
        //Inicia a instância da classe itensJogador
        self.itens = [[DQItensJogador alloc] init];
        self.armadilhas =[[DQArmadilhasJogador alloc]init];
        
        Usuario *infoSave = [DQCoreDataController procurarJogador:@"Jogador1"];
        if (infoSave !=nil) {
            self.fome = [[infoSave fome]intValue];
            self.sede = [[infoSave sede]intValue];
            self.vida= [[infoSave vida]intValue];
            self.respeito = [[infoSave respeito]intValue];
            
            
            self.itens = [infoSave itens];
            self.armadilhas = [infoSave armadilhas];
        }
        
        
        
//        if ([DQControleUserDefalts itensAtuaisJogador]!=nil) {
//            self.itens.dicionarioDeItensJogador = [DQControleUserDefalts itensAtuaisJogador];
//        }
//        self.armadilhas =[[DQArmadilhasJogador alloc]init];
//        
//        
//        if ([DQControleUserDefalts armadilhasAtuaisJogador]!=nil) {
//            self.armadilhas.arrayDeArmadilhasJogador = [DQControleUserDefalts armadilhasAtuaisJogador];
//        }
        self.controleMissoes = [[DQMissaoControle alloc]initCena:self.scene];
        
        //se nao existe nenhuma missao ainda
//        if([DQControleUserDefalts missaoAtualJogador] != nil){
          //  NSDictionary *missao = [DQControleUserDefalts missaoAtualJogador];
        if (infoSave !=nil) {
            
        
            NSDictionary *missao = [infoSave missao];
            self.controleMissoes.emMissao = [[missao objectForKey:@"EmMissao"]boolValue];
            self.controleMissoes.parteAtual = [[missao objectForKey:@"ParteAtual"]intValue];
            self.controleMissoes.proximaMissao = [[missao objectForKey:@"MissaoAtual"]intValue];
            
            [self.controleMissoes iniciarMissao];
        }
       // }
        
        self.controleSom=[[DQControleSom alloc]initControleSom:Jogador];
        [self addChild:self.controleSom];
        
        self.distAndar=100;
        self.impulsoPulo=210;
        [self setName:@"Jogador"];
    }
    
    //retorna o jogador
    return self;
}
-(void)atualizaEstadoJogador{
    
    if (![DQControleUserDefalts estadoJogadorAtualizado]) {
        [DQControleUserDefalts setEstadoInicialJogador];
    }
    
    NSDictionary *estadoJogador=[DQControleUserDefalts estadosJogador];
    
    self.fome= [[estadoJogador objectForKey:@"Fome"]floatValue];
    self.vida=[[estadoJogador objectForKey:@"Vida"]floatValue];
    self.sede=[[estadoJogador objectForKey:@"Sede"]floatValue];
    self.respeito=[[estadoJogador objectForKey:@"Respeito"]floatValue];
}


-(void)iniciarAnimacoes:(NSDictionary*)animacoes{
    
    if (![[animacoes objectForKey:@"Andando"]  isEqual:@""]) {
        framesAndando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Andando"]]];
        
    }
    if (![[animacoes objectForKey:@"Pulando"]  isEqual:@""]) {
        framesPulando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Pulando"]]];
        
    }
    if (![[animacoes objectForKey:@"Parado"]  isEqual:@""]) {
        framesParado = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Parado"]]];
        
    }
    if (![[animacoes objectForKey:@"Escalando"]  isEqual:@""]) {
        framesEscalando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Escalando"]]];
        
    }
    if (![[animacoes objectForKey:@"Caindo"]  isEqual:@""]) {
        framesCaindo = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Caindo"]]];
        
    }
    if (![[animacoes objectForKey:@"Derrapando"]  isEqual:@""]) {
        framesDerrapando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Derrapando"]]];
        
    }
    
    //apos ler tudo anima o jogador
    [self animarParado];
    
}
-(NSMutableArray*)lerFrames :(SKTextureAtlas*)pastaFrames{
    NSInteger numImagens = pastaFrames.textureNames.count;
    NSMutableArray *frames =[[NSMutableArray alloc]init];
    
    for (int i=1; i <= numImagens; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [pastaFrames textureNamed:textureName];
        [frames addObject:temp];
    }
    
    return frames;
}

//Singleton do jogador
+(id)sharedJogador
{
    static DQJogador *jogador = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jogador = [[self alloc]initJogadorSprite:@"Jogador"];
    });
    
    return jogador;
}


//funcao para animar o jogador andando
-(void)animarAndando{
    
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoAndando"];
    [self.controleSom tocarSomLooping:[self.controleSom configuraPlayerSom:@"Passo" nLoops:-1]];
    
}

//funcao para animar o jogador derrapando
-(void)animarDerrapando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesDerrapando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoDerrapando"];
}

//funcao para animar o jogador escalando
-(void)animarEscalando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesEscalando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoEscalada"];
}
//anima ele parado
-(void)animarParado{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesParado
                                                                              timePerFrame:0.9f
                                                                                    resize:NO
                                                                                   restore:YES]]withKey:@"animandoParado"];
}
//funcao para animar jogador pulando
-(void)animarPular{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    
        
    
    [self.spriteNode runAction:[SKAction animateWithTextures:framesPulando timePerFrame:0.5f                                           resize:NO restore:YES] withKey:@"animandoPulo"];
    
    
}

//funcao para animar jogador caindo
-(void)animarCaindo{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction animateWithTextures:framesCaindo timePerFrame:0.1f                                           resize:NO restore:YES] withKey:@"animandoCaindo"];
}




//funcao da acao de pulo do jogador
-(void)pular{
    
    //verifica se ele esta no ar, se ja estiver nao pula
    if (self.estaNoChao && ![self.spriteNode actionForKey:@"animandoEscalada"]) {
        
        // aplica um impulso para cima , ou seja o pulo e seta que ele esta no ar
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, self.impulsoPulo)];
        
        self.estaNoChao = NO;
        
        
        // anima ele pulando
        [self animarPular];
    }
}

//TODO:- Melhorar metodo e passar ele p o DQUteis
-(BOOL)estaComContadorGeiger{
    return [self estaComItem:@"Contador Geiger"];
}
-(BOOL)estaComItem:(NSString*)nomeItem{

    return [DQUteis array:[self.itens arrayItensJogador] contemString:nomeItem];
}

//Alterado cabeçalho funçao
//-(void)andarParaDirecao:(NSString*)direcao{
-(void)andarParaDirecao:(char)direcao eDistancia:(float)distancia{
    if (![self.spriteNode actionForKey:@"animandoEscalada"] ) {
        
        //variavel SKAction- define a direcao do movimento
        SKAction *movimentar =[[SKAction alloc]init];
        
        //se a direcao for para direita
        if (direcao=='D') {
            
            self.andandoParaDirecao = @"D";
            //Alterado para usar da propriedade
            //movimentar=[SKAction moveByX:self.distAndar y:0 duration:1.0];
            movimentar=[SKAction moveByX:distancia y:0 duration:1.0];
            
            if(self.physicsBody.velocity.dx > 10 && self.physicsBody.velocity.dy < -10){
                [self.physicsBody setVelocity:CGVectorMake(10, -10)];
            }
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*1;
        }else{
            
            self.andandoParaDirecao = @"E";
            //movimentar=[SKAction moveByX:(self.distAndar *-1) y:0 duration:1.0];
            movimentar=[SKAction moveByX:distancia y:0 duration:1.0];
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*-1;
            
        }
        
        //anda para direcao
        [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
    }
}

-(void)configuraCorpoFisico{
    CGMutablePathRef path=CGPathCreateMutable();
    
    CGPoint primeiroPonto=CGPointMake((CGRectGetMidX(self.spriteNode.frame)+15), CGRectGetMinY(self.spriteNode.frame)+20);
    CGPathMoveToPoint(path, NULL, primeiroPonto.x,primeiroPonto.y);
    
    CGPoint segundoPonto=CGPointMake((CGRectGetMidX(self.spriteNode.frame)-15), CGRectGetMinY(self.spriteNode.frame)+20);
    CGPathAddLineToPoint(path, NULL, segundoPonto.x,segundoPonto.y);
    
    CGPoint terceiroPonto=CGPointMake(CGRectGetMinX(self.spriteNode.frame)+15, CGRectGetMidY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, terceiroPonto.x, terceiroPonto.y);
    
    CGPoint quartoPonto=CGPointMake(CGRectGetMidX(self.spriteNode.frame), CGRectGetMaxY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, quartoPonto.x, quartoPonto.y);
    
    CGPoint quintoPonto=CGPointMake(CGRectGetMaxX(self.spriteNode.frame)-15, CGRectGetMidY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, quintoPonto.x, quintoPonto.y);
    
    [self setPhysicsBody:[SKPhysicsBody bodyWithPolygonFromPath:path]];
    
    self.physicsBody.usesPreciseCollisionDetection=YES;
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.mass = 0.566667;
    self.physicsBody.restitution = 0;
    
    
}
//Metodo que altera a Fome do jogador
-(void)alterarFomeJogador: (int)fome
{
    
    
    //está ficando com fome
    if(fome > 0){
        if ((self.fome - fome) < 0) {
            [self setFome:0];
        }
        else{
            [self setFome:(self.fome - fome)];
        }
    }
    //está perdendo a fome
    else{
        if ((self.fome -(fome)) >100) {
            [self setFome:100];
        }
        else{
            [self setFome:(self.fome -(fome))];
        }
    }
}

//Metodo que altera a Sede do jogador
-(void)alterarSedeJogador: (int)sede
{
    //está ficando com sede
    if(sede > 0){
        if ((self.sede - sede) < 0) {
            [self setSede:0];
        }
        else{
            [self setSede:(self.sede - sede)];
        }
    }
    //está perdendo a sede
    else{
        if ((self.sede -(sede)) > 100) {
            [self setSede:100];
        }
        else{
            [self setSede:(self.sede -(sede))];
        }
    }
}

//Metodo que altera a Vida do jogador
-(void)alterarVidaJogador: (int)vida
{
    //está ficando sem vida
    if(vida < 0){
        if ((self.vida - vida) < 0) {
            [self setVida:0];
        }
        else{
            [self setSede:(self.vida - vida)];
        }
        
        [self.controleSom tocarSom:[self.controleSom configuraPlayerSom:@"somPerdeuVida"]];
    }
    //está ganhando vida
    else{
        if ((self.vida + vida) > 100) {
            [self setVida:100];
        }
        else{
            [self setSede:(self.vida + vida)];
        }
    }
}

//Método para parar de andar
-(void)pararAndar{
    self.andandoParaDirecao =@"";
    //remove as acoes de andar e animarAndando
    [self removeActionForKey:@"andar"];
    [self.spriteNode removeActionForKey:@"animandoAndando"];
    
    [self.controleSom pararSom];
}

//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(NSString*)direcao{
    //se puder escalar
    if (self.podeEscalar) {
        SKAction *escalar=[[SKAction alloc]init];
        
        //Desliga a gravidade para o Node
        self.physicsBody.dynamic=NO;
        // verifica para qual direcao sera a escalada
        if ([direcao isEqualToString:@"C"]) {
            //Sobe
            escalar =[SKAction moveByX:0.0f y:90.0f duration:1.0];
            
        }else if([direcao isEqualToString:@"B"]){
            //Desce
            escalar =[SKAction moveByX:0.0f y:-90.0f duration:1.0];
        }
        //anima o jogador escalando
        [self animarEscalando];
        // move o jogador
        [self runAction:[SKAction repeatActionForever:escalar]withKey:@"escalar"];
    }
}
//Funcao para parar de derrapar
-(void)pararDerrapar{
    [self.spriteNode removeActionForKey:@"animandoDerrapando"];
}

//funcao para parar a escalada do jogador
-(void)pararEscalar{
    self.podeEscalar = NO;
    if (![self.physicsBody isDynamic]) {
        self.physicsBody.dynamic = YES;
    }
    [self.spriteNode removeActionForKey:@"animandoEscalada"];
    [self removeActionForKey:@"escalar"];
}

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada{
    [[self.spriteNode actionForKey:@"animandoEscalada"]setSpeed:0];
    [self removeActionForKey:@"escalar"];
}

//funcao que atualiza o status da missao
-(void)atualizarStatusMissao{
    [self.controleMissoes atualizarCena:self.scene];
    [self.controleMissoes colocarBalaoDeMissao];
}


//funcao a fazer para ele interagir com pessoas
-(void)interagirComNPC:(NSString*)nomeNPC ControleDeFalas:(DQFalasNoJogoControle*)controleDeFalas{
    
    //Se nao estiver em missao
    if (!self.controleMissoes.emMissao) {
        //Senao esta iniciando uma nova  missao
        if (![self.controleMissoes iniciarNovaMissaoNPC:nomeNPC]) {
            //Cria uma caixa de fala com as falas de respeito e a adiciona na cena
            NSString *keyDaParte = [NSString stringWithFormat:@"Respeito%i", (self.respeito/10)*10];
            
            SKSpriteNode *caixaDeFala =[controleDeFalas mostrarFalaComNPC:nomeNPC KeyDaFala:keyDaParte Missao:nil Tamanho:self.scene.size];
            [self.scene addChild:caixaDeFala];
        }
    }
    //Se esta em missao
    if (self.controleMissoes.emMissao) {
        NSString *keyDaParte;
        NSString *missao = self.controleMissoes.missao.ID;
        //Se é o NPC que passa a parte da missao
        if ([self.controleMissoes passarParteMissao:nomeNPC inventario:[self.itens arrayItensJogador]]) {
            //Cria a key de uma fala principal da missao
            keyDaParte = [NSString stringWithFormat:@"Parte%i", self.controleMissoes.parteAtual-1];
            
            [self entregarItem];
            [self receberItem];
            [self alterarEstados];
            if(self.controleMissoes.parteAtual+1 > self.controleMissoes.missao.quantidadeDePartes){
                [self.controleMissoes fimDaMissao];
            }
            
        }
        //Se nao é o NPC que passa a parte da missao ou nao tem o item
        else{
            //Cria uma key de uma fala secundaria da missao
            keyDaParte = [NSString stringWithFormat:@"Parte%iR", self.controleMissoes.parteAtual];
        }
        
        //Cria a caixa de fala com as key obtidas e a adiciona na tela
        SKSpriteNode *caixaDeFala = [controleDeFalas mostrarFalaComNPC:nomeNPC KeyDaFala:keyDaParte Missao:missao Tamanho:self.scene.size];
        
        [self.scene addChild:caixaDeFala];
    }
}


//Método chamado quando a missão descreve que um item deve ser entregue
-(void)entregarItem{
    
    if ([[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ArmadilhasEntregue"]) {
        NSMutableArray*armadilhasParaEntregar = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ArmadilhasEntregue"];
        for (int i = 0; i< armadilhasParaEntregar.count; i++) {
            NSString *nomeArmadilha = [armadilhasParaEntregar objectAtIndex:i];
            
            
            [self.armadilhas receberArmadilha:nomeArmadilha];
        }
    }
    
    
    NSMutableArray*itemsParaEntregar = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ItemEntregue"];
    
    for (int i = 0; i< itemsParaEntregar.count; i++) {
        NSString *nomeItem = [[itemsParaEntregar objectAtIndex:i]objectForKey:@"Nome"];
        int quantidade = [[[itemsParaEntregar objectAtIndex:i]objectForKey:@"Quantidade"]intValue];
        
        [self.itens entregarItem:nomeItem  quantidade:quantidade];
    }
}


//Método chamado quando a missão descreve que um item deve ser recebido
-(void)receberItem{
    NSMutableArray*itemsParaReceber = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ItemRecebido"];
    
    for (int i = 0; i< itemsParaReceber.count; i++) {
        NSString *nomeItem = [[itemsParaReceber objectAtIndex:i]objectForKey:@"Nome"];
        int quantidade = [[[itemsParaReceber objectAtIndex:i]objectForKey:@"Quantidade"]intValue];
        
        [self.itens receberItem:nomeItem  quantidade:quantidade];
    }
    
}

//Metodo para alterar os estados do jogador em missao
-(void)alterarEstados{
    
    NSDictionary *dicionario = [[NSDictionary alloc] initWithDictionary:[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]];
    
    //Ver se muda os estados
    //fome
    int fome = [[dicionario objectForKey:@"Fome"] intValue];
    if(fome != 0){
        [self alterarFomeJogador:fome];
    }
    
    //sede
    int sede = [[dicionario objectForKey:@"Sede"] intValue];
    if(sede != 0){
        [self alterarSedeJogador:sede];
    }
    
    //vida
    int vida = [[dicionario objectForKey:@"Vida"] intValue];
    if(vida != 0){
        [self alterarVidaJogador:vida];
    }
}

@end
