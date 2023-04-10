


#' Câncer de pulmão em camundongos
#'
#' @name pulmao
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Experimento de tumorigenicidade sobre tumores pulmonares para 144 camundongos RFM machos. Os dados consistem no tempo até a morte de cada animal medido em dias, e um indicador de presença ou ausência de tumor pulmonar no momento da morte. O experimento envolve dois tratamentos, ambiente convencional (96 camundongos) e ambiente livre de germes (48 camundongos). Tumores pulmonares em camundongos RFM são predominantemente não letais, o que significa que a ocorrência de um tumor não não alterar a taxa de mortalidade.
#' @format Data frame com 144 linhas e 3 variáveis:
#' \itemize{
#'   \item tempo: tempo até a morte do camundongo (em dias)
#'   \item tumor: presença/ausência do tumor
#'   \item ambiente: ambiente convencional ou ambiente livre de germes
#' }
#' @references
#'
#' \insertRef{2006Sun}{sobrevivencia}
#'
NULL




#' Câncer de mama
#'
#' @name mama
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo retrospectivo realizado com 94 mulhres, das quais 46 receberam o tratamento somente com radioterapia e 48 com radioterapia e quimioterapia. O evento de interesse foi definido como a ocorrência da primeira (moderada ou severa) retração de uma mama. As pacientes foram inicialmente observadas a cada 4-6 meses e, assim que ficavam melhores o intervalo entre as visitas aumentava.
#' @format Data frame com 94 linhas e 4 variáveis:
#' \itemize{
#'   \item esquerda: limite inferior do intervalo (em meses)
#'   \item direita: limite superior do intervalo (em meses)
#'   \item terapia: radioterapia ou radioterapia + quimioterapia
#'   \item evento: indicadora da ocorrência do evento de interesse (retração)
#' }
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
NULL

#' Eficácia da imunização pela malária
#'
#' @name malaria
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo experimental realizado com camundongos para verificar a eficácia da imunização pela malária. O estudo, que foi conduzido no Centro de Pesquisas Renee Rachou, Fiocruz-MG, contou com 44 camundongos que foram infectados pela malária. Os camundongos foram aleatoriamente divididos em 3 grupos: grupo: 1 - imunizados 30 dias antes da infecção; 2 - sem imunização e com infecção pela malária; 3 - sem imunização e com infecção pela malária e esquistossomose.
#' @format Data frame com 44 linhas e 3 variáveis:
#' \itemize{
#'   \item tempo: tempo (em dias) decorrido deste a infecção pela malária até a morte do camundongo
#'   \item cens: indicador de falha ou censura (1 - falha; 0 - censura)
#'   \item grupo: 1 - imunizados 30 dias antes da infecção; 2 - sem imunização e com infecção pela malária; 3 - sem imunização e com infecção pela malária e esquistossomose;
#'   \item evento: indicadora da ocorrência do evento de interesse (retração)
#' }
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
NULL



#' Tempos de reincidência de tumor sólido
#'
#' @name tumores
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo realizado com o objetivo de avaliar o tempo de reincidência de pacientes com tumores sólidos. O experimento, cuja duração foi de 18 meses, teve início com apens 3 pacientes, e 7 pacientes entram no estudo durante o perı́odo de acomapanhamento.
#' @format Data frame com 10 linhas e 3 variáveis:
#' \itemize{
#'   \item entrada: tempo de entrada do paciente no estudo (em meses)
#'   \item saida: tempo de saída do paciente no estudo (em meses)
#'   \item evento: indicadora da ocorrência do evento de interesse (reincidência)
#' }
#' @references
#'
#' \insertRef{bookMarta}{sobrevivencia}
#'
NULL


#' Tempo de vida de isoladores elétricos
#'
#' @name isoladores
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Um fabricante de em tipo de isolador elétrico quer conhecer o comportamento do seu produto funcionando na temperatura de 200º C. Um teste de vida foi realizado nestas condições usando 60 isoladores elétricos. O teste terminou quando 45 isoladores falharam (censura à direita do tipo II). As 15 unidades que não falharam até o final do teste foram censuradas no tempo t = 2729 horas.
#' @format Data frame com 60 linhas e 2 variáveis:
#' \itemize{
#'   \item tempo: tempo de vida dos isoladores (em horas)
#'   \item evento: indicadora da ocorrência do evento de interesse (retração)
#' }
#' @references
#'
#' \insertRef{bookMarta}{sobrevivencia}
#'
NULL



#' Manutenção preventiva de transformadores
#'
#' @name transformadores
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Uma companhia de energia elétrica deseja estabelecer uma política de manutenção preventiva para seus transformadores, visando minimizar o custo esperado associado a sua manutenção. Tal política de manutenção deve levar em conta ambos os custos decorrentes da paralização programada (manutenção preventiva) e não programada (falha e posterior reparo do tranformador). Com esse objetivo, 30 transformadores foram colocados sob teste e concluiu-se que o tempo ótimo entre manutenções preventivas é igual a 6285 horas.
#' @format Data frame com 61 linhas e 5 variáveis:
#' \itemize{
#'   \item tranformador: indicadora do transformador sendo acompanhado
#'   \item unidade: indicadora do tranformador sendo acompanhado (transformadores que passam por manutenção preventiva são considerados novas unidades)
#'   \item preventiva: variável indicadora (1 - ocorrência de manutenção preventiva; 0 -  caso contrário)
#'   \item tempo: tempo até a falha do transformador (em horas)
#'   \item evento: indicadora da ocorrência do evento de interesse (falha do tranformador)
#' }
#' @references
#'
#' \insertRef{2007Gilardoni}{sobrevivencia}
#'
NULL


#' The Leukemia Survival Data in North-West England
#'
#' @name leukUK
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description A dataset on the survival of acute myeloid leukemia in 1,043 pateietns, first analyzed by \insertCite{2002Silvia}{sobrevivencia}. It is of interest to investigate possible spatial variation in survival after accounting for known subject-specific prognostic factors, which include age, sex, white blood cell count (wbc) at diagnosis, and the Townsend score (tpi) for which higher values indicates less affluent areas. Both exact residential locations of all patients and their administrative districts (24 districts that make up the whole region) are available.
#' @format A sf/data frame with 1043 rows and 8 variables:
#'\itemize{
#' \item time: survival time in days
#'  \item cens: right censoring status 0=censored, 1=dead
#'  \item age: age in years
#'  \item sex:male=1 female=0
#'  \item wbc:white blood cell count at diagnosis, truncated at 500
#'  \item tpi: the Townsend score for which higher values indicates less affluent areas
#'  \item district:administrative district of residence
#'  \item geometry: georeferenced data needed to plot maps.
#'}
#'
#' \insertRef{2002Silvia}{sobrevivencia}
#'
NULL


#' The Leukemia Survival Data in North-West England
#'
#' @name nwengland
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Georeferenced data on 24 administrative districts in the North-West of England used in \insertCite{2002Silvia}{sobrevivencia}.
#' @format A sf/data frame with 2 rows and 2 variables:
#'\itemize{
#' \item district: district number
#'  \item geometry: georeferenced data needed to plot maps.
#'}
#'
#' \insertRef{2002Silvia}{sobrevivencia}
#'
NULL


#' The Leukemia Survival Data in North-West England
#'
#' @name leukUK
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description A dataset on the survival of acute myeloid leukemia in 1,043 pateietns, first analyzed by \insertCite{2002Silvia}{sobrevivencia}. It is of interest to investigate possible spatial variation in survival after accounting for known subject-specific prognostic factors, which include age, sex, white blood cell count (wbc) at diagnosis, and the Townsend score (tpi) for which higher values indicates less affluent areas. Both exact residential locations of all patients and their administrative districts (24 districts that make up the whole region) are available.
#' @format A sf/data frame with 1043 rows and 8 variables:
#'\itemize{
#' \item time: survival time in days
#'  \item cens: right censoring status 0=censored, 1=dead
#'  \item age: age in years
#'  \item sex:male=1 female=0
#'  \item wbc:white blood cell count at diagnosis, truncated at 500
#'  \item tpi: the Townsend score for which higher values indicates less affluent areas
#'  \item district:administrative district of residence
#'  \item geometry: georeferenced data needed to plot maps.
#'}
#'
#' \insertRef{2002Silvia}{sobrevivencia}
#'
NULL


#' Casos de diarréia em crianças
#'
#' @name diarreia
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo sobre o efeito da suplementação de vitamina A na diarreia no nordeste do Brasil em uma coorte de crianças de 6 a 48 meses são referentes ao ensaio comunitário randomizado placebo-controlado, realizado entre dezembro/1990 e dezembro/1991. Banco de dados disponível em \insertRef{bookFiocruz}{sobrevivencia} e cedido pelo Instituto de Saúde Coletiva da Universidade Federal da Bahia. O banco de dados consiste em 860 crianças (426 no grupo placebo e 434 no grupo vitamina), gerando um total de 5.592 registros e 11 variáveis. Esse banco de dados é caracterizado pela presença de múltiplos eventos (cada criança pode ter um ou mais episódios de diarreia ao longo de sua permanência no estudo).
#' @details No arquivo, cada linha representa um tempo entre episódios de diarreia. As covariáveis constantes (grupo, sexo e idade) têm seus valores repetidos em todas as linhas referentes a essa criança. As covariáveis que mudam de episódio para episódio são diasant, mediadej e enum.
#' @format Data frame com 5592 linhas e 11 variáveis:
#'\itemize{
#'  \item numcri: identificador da criança
#'  \item grupo: vit = receberam vitamina A, pla = placebo
#'  \item sexo: fem = feminino, masc = masculino
#'  \item idade: idade em meses no início do estudo
#'  \item ini: data no início do período sem diarreia
#'  \item fim: data no fim do período sem diarreia
#'  \item diasant: duração em dias do episódio de diarreia anterior
#'  \item mediadej: média de dejeções líquidas ou semilíquidas do episódio de diarreia anterior
#'  \item enum: numeração das observações para cada criança
#'  \item status: 0 = censura, 1 = evento (diarreia)
#'  \item tempo: dias sem diarreia (fim-ini)
#'}
#' @source \url{http://sobrevida.fiocruz.br/diarreia.html}
#'
#' \insertRef{bookFiocruz}{sobrevivencia}
#'
NULL


#' Ocorrências de doenças oportunistas em pessoas diagnosticadas com AIDS
#'
#' @name oportunista
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Os dados utilizados para o tempo até a ocorrência de doenças oportunistas provêm de uma coorte de pacientes HIV positivos atendidos no Hospital Universitário Gaffrée e Guinle (Unirio). As variáveis foram obtidas a partir dos prontuários clínicos. Registrou-se, para cada paciente com Aids, o tempo até a ocorrência de cada doença ou sintomatologia caracteristicamente relacionada à imunodepressão: candidíase, tuberculose, alguns sinais hematológicos, herpes zoster, pneumonia por Pneumocistis.
#' @details Os dados estão armazenados de maneira que cada linha do arquivo indica o tempo do diagnóstico de Aids até a ocorrência de uma doença oportunista.
#' @format Data frame com 1195 linhas e 11 variáveis:
#'\itemize{
#'  \item reg: identificador do paciente
#'  \item sex: F = feminino, M = masculino
#'  \item esc: 0 = sem escolaridade, 1 = até quatro anos de estudo, 2 = ensino fundamental, 3 = ensino médio, 4 = ensino superior
#'  \item idade: idade em anos na entrada do estudo
#'  \item udi: uso de drogas injetáveis: 0 = não, 1 = sim
#'  \item sexual: comportamento sexual: 0 = não, 1 = sim
#'  \item ini: data da entrada no estudo (diagnóstico de Aids)
#'  \item oport: doença oportunista: Candida = candidíase, Tuberc = tuberculose, Hemato = algumas alterações hematológicas, Herpes = herpes zoster, Pneumo = pneumonia por Pneumocistis
#'  \item fim: data do diagnóstico do evento relacionado à imunodepressão
#'  \item status: 0 = censura, 1 = ocorrência do evento
#'  \item tempo: fim - ini
#'}
#' @source \url{http://sobrevida.fiocruz.br/aidsoport.html}
#'
#' \insertRef{bookFiocruz}{sobrevivencia}
#'
NULL

#' E1684 Melanoma Clinical Trial.
#'
#' @name e1684
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Two-arm phase III clinical trial conducted by the Eastern Cooperative Oncology Group (ECOG) to comparing high-dose interferon (IFN) to observation (OBS). There were a total of 286 patients diagnosed with melanoma enrolled in the study, which accrued from 1984 to 1990, and the study was unblinded in 1993.
#' @format A data frame with 286 rows and 10 variables:
#' \itemize{
#'   \item trt: treatment (1 - observation, 2 - IFN)
#'   \item failtime: time to relapse from randomization
#'   \item failcens: failure indicator (1 - failure; 0 - otherwise)
#'   \item survtime: time from relapse to death
#'   \item survcens: failure indicator (1 - failure; 0 - otherwise)
#'   \item age: patient's age (in years)
#'   \item node: 4 nodal categories
#'   \item sex: patient's (0=male, 1=female)
#'   \item ps: patient's performance status (0 - fully active; 1 - other)
#'   \item breslow: Breslow depth (in mm)
#' }
#' @references
#'
#' \insertRef{bookIbrahim}{sobrevivencia}
#'
NULL


#' Degradação de luz emitida por lasers
#'
#' @name lasers
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Em uma corrente de funcionamento estável, a luz emitida por lasers degrada ao longo do tempo. Para manter a intensidade da luz emitida constante é necessário que a corrente funcional aumente ao longo do tempo. A degradação neste caso é medida através da porcentagem no aumento da corrente funcional (relativo à corrente original). No estudo em questão 15 lasers foram observados no intervalo 250-4000 horas, coletando os valores da corrente funcional a cada 250 horas. Considera-se que o laser irá falhar depois que ele perder 10% da sua intensidade.
#' @format A data frame with 255 rows and e 3 variables:
#' \itemize{
#'   \item unidade: indicadora do laser sendo testado
#'   \item hora: hora de medição da corrente funcional dos lasers
#'   \item degradacao: porcentagem no aumento da corrente funcional (relativo à corrente original)
#' }
#' @references
#'
#' \insertRef{2005Hamada}{sobrevivencia}
#'
NULL



#' Dados experimentais utilizando camundongos
#'
#' @name camundongos
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Um estudo laboratorial foi realizado para investigar o efeito protedor do fungo Saccharomycs boulardii em 93 ratos debilitados imunologicamente. Inicialmente, os sistemas imunológicos dos ratos foram debilitados quimicamente e, a seguir, 4 tratamentos (controle e fungo nas dosagens 10mg, 1mg  e 0.1mg) foram alocados aleatoriamente a cada animal. A variável resposta foi o tempo de vida (em dias) após a aplicação do tratamento. O estudo teve por objetivo comparar os tratamentos controlando pelo peso inicial dos ratos.
#' @format Data frame com 93 linhas e 4 variáveis:
#' \itemize{
#'   \item grupo: 1 - controle; 2 - fungo na dosagem 10mg, 3 - fungo na dosagem 1mg  e 4 - fungo na dosagem 0.1mg
#'   \item peso: peso do rato no início do estudo
#'   \item tempo: tempo de vida (em dias) após a aplicação do tratamento
#'   \item evento: indicadora da ocorrência do evento de interesse (retração)
#' }
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
NULL


#' Dados de hepatite
#'
#' @name hepatite
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo clínico aleatorizado realizado para investigar da terapia com esteróide no tratameno de hepatite viral aguda. Os 29 pacientes com a doença foram aleatorizados para receber um placebo ou o tratamento com esteróide. Cada paciente foi acompanhado por 16 semanas, ou até a morte, ou até a perda de acompanhamento.
#' @format Data frame com 29 linhas e 3 variáveis:
#' \itemize{
#'   \item tempos: tempo até a morte do paciente (em semanas) em decorrência da hepatite ou a perda do acompanhamento.
#'   \item cens: indicadora da ocorrência do evento de interesse
#'   \item grupos: 1 - controle; 2 - esteróide
#' }
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
NULL


#' Sinusite em pacientes com HIV
#'
#' @name sinusite
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Estudo realizado no Departamento de Otorrinolaringologia da UFMG, entre março de 1993 e fevereiro de 1995, com o objetivo de verificar a hipótese de que a infecção pelo HIV aumenta o risco de sinusite. Participaram do estudo 91 pacientes infectados com HIV e 21 pacientes não infectados com HIV.
#' @format Data frame com 133 linhas e 12 variáveis:
#' \itemize{
#'   \item pac: identificador do paciente
#'   \item id: idade do paciente (em anos)
#'   \item sex: sexo do paciente (0 - masculino; 1 feminino)
#'   \item grp: grupo de risco (1 - paciente HIV soronegativo; 2 - paciente HIV soropositivo assintomático; 3 - paciente com ARC; 4 paciente com AIDS)
#'   \item ti: tempo inicial (em dias)
#'   \item tf: tempo final (em dias)
#'   \item cens: indicadora de falha ou censura
#'   \item cd4: contagem de células cd4 medida no início do estudo
#'   \item cd8: contagem de células cd8 medida no início do estudo
#'   \item ats: atividade sexual (1 - homossexual; 2 - bissexual; 3 heterossexual)
#'   \item ud: use de droga injetável (1 - sim; 2 - não)
#'   \item ac: uso de cocaína por aspiração (1 - sim; 2 - não)
#' }
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
NULL


#' Tempo de vida de componentes mecânicos
#'
#' @name compmec
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Um componente mecânico possui a variável temperatura como fator de aceleração para a ocorrência de falha. Com o objetivo de estudar o tempo de vida (em horas) dos componentes, um engenheiro realizou um experimento envolvendo 40 componentes, divididos igualmente em 4 diferentes temperaturas medidas em Kelvin: 300, 350, 400 e 500. A temperatura de 300 graus Kelvin corresponde a temperatura normal de operação do componente, e o modelo de Arrenhius foi utilizado para estudar a confiabilidade dos componentes mecânicos.
#' @format Data frame com 40 linhas e 3 variáveis:
#' \itemize{
#'   \item temperatura: temperatura medida em Kelvin
#'   \item tempo: tempo de vida dos componentes mecânicos (em horas)
#'   \item evento: indicadora da ocorrência do evento de interesse (retração)
#' }
#' @references
#'
#' \insertRef{bookMarta}{sobrevivencia}
#'
NULL
