##Simulation:

	A tabela ?? mostra "operating point results" do circuito sob análise. A tabela apresenta uma menção do Nodo 8, que tem a ver com a inclusão de uma fonte de tensão nula no nodo 6, que foi utilizada para medir o valor de corrente que atravessa o nodo 6, levando à formação do nodo 8, entre a fonte de tensão nula e a Resistência 7. Daí o nodo 8 ter a mesma tensão que o nodo 6, já que a diferença de potencial entre os extremos da fonte de tensão é nula.
	Como o circuito a ser analisado é um circuito bem definido,com fontes indepentes de tensão (Va) e de corrente (Id), e com componentes em que se verificam relações lineares entre a diferença de tensão e a corrente, sendo que no caso das fontes dependentes, estão descritas as relações na Imagem ??, e no caso das resistências, estas obedecem à lei de Ohm:
						V = R*I,
então seria de esperar que a forma matricial do sistema de equações lineares obtida pela aplicação dos métodos abordados na secção teórica seja invertível, e assim, terá uma solução possível e determinada.
	É de realçar que os valores obtidos da simulação estão em concordância com os valores obtidos pelos métodos de Mesh e dos Nodos, apresentando diferenças negligentes entre os valores, devido à apresentação dos valores no simulador e no programa Octave.
	Logo, pode-se verificar que os métodos abordados na secção téorica (Método do Mesh e Método dos Nodos) dão as mesmas soluções que o simulador, sendo que se confirma a legitimidade dos métodos utilizados, tal como se esperava, sendo que é possível que o programa do simulador recorra a estes metódos para simular o circuito.
	Contudo, o simulador e os métodos utilizados produzem soluções que poderão não se verificar num circuito real, devido a vários fatores, (entre eles o efeito de Joule nos cabos que ligam os componentes, e outros possíveis erros aleatórios e ou sistemáticos, que comprometem a precisão e a exatidão dos resultados), mas os seus resultados não deixam de ser uma aproximação dos valores reais que se poderiam verificar numa versão real do circuito analisado.
	
	
	
##O texto pode conter partes que poderão ser utilizadas noutras partes do relatório.
