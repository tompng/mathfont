# Math font

## What's this?
```ruby
register(:a){|x,y|1/2.0+32/(1+512*(x**4+(y+1/4.0)**2))-x**6-(3/2.0-2*y-8*x**2+5*x**4)**2}

#  plot where a.call(x,y) is greater than 0
%(
|                                                                
|                             .,gg,,                             
|                           .gMMMMMMQ,                           
|                          gQMMMMMMMMMg,                         
|                         QMMMMMMMMMMMMM!                        
|                        pMMMMMMMMMMMMMMM,                       
|                      .aMMMMMMMMMMMMMMMMM,                      
|                     .QMMMMMMMMMMMMMMMMMMMu                     
|                     QMMMMMMMMMMMMMMMMMMMMM!                    
|                    uMMMMMMMMMMMMMMMMMMMMMMQ.                   
|                   gMMMMMMMMMMMMMMMMMMMMMMMMp,                  
|                  uMMMMMMMMMMMMMMMMMMMMMMMMMMQ.                 
|                 .MMMMMMMMMMMMMMMMMMMMMMMMMMMMa                 
|                 QMMMMMMMMMMMMTT*TTMMMMMMMMMMMM!                
|                uMMMMMMMMMMMT^     *MMMMMMMMMMMQ.               
|               gMMMMMMMMMMM0        ^MMMMMMMMMMMp,              
|              !MMMMMMMMMMMT          ?#MMMMMMMMMMQ              
|             ,MMMMMMMMMMMM            rMMMMMMMMMMMp             
|             pMMMMMMMMMMMM,          .aMMMMMMMMMMMM,            
|            rMMMMMMMMMMMMMMp,      .uQMMMMMMMMMMMMMM            
|           aMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.          
|          .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMa          
|          pMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM,         
|         rMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM         
|        .MMMMMMMMMMMM#TTTT????????????*TTT#MMMMMMMMMMMMa        
|       ,pMMMMMMMMMMT*                      ^TTMMMMMMMMMMg       
|      .QMMMMMMMMMT                            ?MMMMMMMMMMu      
|      aMMMMMMMMM#                              ?MMMMMMMMMM.     
|     !MMMMMMMMMT                                ?#MMMMMMMMQ     
|     QMMMMMMMMV                                  ^MMMMMMMMM!    
|    pMMMMMMMM0                                    ^MMMMMMMMQ!   
|    MMMMMMMM#                                      ?MMMMMMMMr   
|    MMMMMMM<                                         MMMMMMMr   
|     MMMMM*                                          ^#MMMMr    
|     ?MMM?                                             TMM#     
|                                                                
|                                                                
)
```

## Usage
### banner
```sh
$ ruby mathfont.rb hello ruby
```
```
|     ggg,ggg,                                                                   
|    rMMMMM#MMMg.        .,         .,       .gpgggggg,,        ,g.          ,g  
|    aMMM?   ^VMQ        QMr        MM!      rMMMMMMMMMMMg.      #Mg       ,QM?  
|    MMMr      MMr       MMr        MMr      aM#?^    ?VMMQ       VMQ,   .gMM^   
|    0MMQ,   .gMM        MMr        MMr      MMp,.    ,uMMT        ^#Mg.,QMV     
|    rMMMMMQMMM#^        MMr        MMr      MMMMMMMMMMMT^           VMMMM^      
|    rMM0??TMMM          0Mr        MM^      MMMMM####MMQ,            #MM?       
|    rMM<   #MM,         rMM.      aMM       MM0       ?MMQ           rMM        
|    rMM    ^MMa          #MQ,   .gMM?       rMQg,,,,,gpMM#           QMM!       
|    rMM     <MM           TMMMMMMMM?        rMMMMMMMMMM#*            #MM?       
|    ^##      TT             ?TTT*^           *T*?????^               <MM        
```



```sh
$ echo "12345\!@#$%" | ruby mathfont.rb -s 16
```
```
|                                                                       .,       
|        pp           ,,gg,            .pMMpu                           QMQr,,.  
|       rMM          ^TTTMMQ,          ^?*#MM           g! !p          aM0       
|       QMM               MMr            .pM<         ,Q*  rM         .MM        
|       MMr              uMM^           MMM^         ,M?  .pM         ?Ma        
|      ,MMr            .gMM^            ^VMQ.        <MpggQMM           *Q,      
|      rMM          .,gMMM:              uMM<              M#           .pM      
|      rM0         V#MMMM####?^        pMMM*               Mr        .,<T?       
|                                       ^                  *^                    
|       .,                                                                       
|       MMr            ,,,,.           .Q  !a           .g,,         ,,,.   ,.   
|       MMr          gQT*?TMp,       .,QM,gQQ,         ,Q#?         !M?0Q .QM^   
|       MMr          Mr ,dTMMp       TMMM#MMMT?       !0.a.         ^#pMT,M#^    
|       MMr          Mr Mr rMM        rM  rM          <QQMMg            gMV      
|       MM<          Mr Mr rMM      ,gQMggQM,.         ^T# M          .QM<,pg,   
|       .,           MQ,MQpMM0      *MMMTMMMT^          .Qd?         ,M#^rM^rM   
|       MMr           ^TTTTTT*       .M  r#           ^*T#           T*   TTT?   
|                                     ^  ^                                       
```






### animation
```sh
$ ruby mathfont.rb -a LGTM
```
https://twitter.com/tompng/status/806385306396196864
