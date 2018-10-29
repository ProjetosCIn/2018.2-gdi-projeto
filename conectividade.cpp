#include <bits/stdc++.h>

using namespace std;

#define MENU 0
#define ENCERRAR 1
#define INSERCAO 2
#define ATUALIZACAO 3
#define REMOCAO 4
#define SELECAO 5
#define SAIR - 1


void func_insercao(){
	system("cls");
	
	int estado = 0;

	

	while(estado != -1){
		if(estado == 0){
			cout << "Modo Insercao:\n\n\n";
			cout << "Neste banco temos as tabelas:";
			cout << "|lugar|personagem|heroi|vilao|mentor|poder|\n \
					 |heroi_poder|luta|equipe|area_de_atuacao|qg|luta|\n \
					 |luta_envolve_equipe|personagem_filiacao_equipe|simbolo|\n\n";
			cout << "1 - Realizar a insercao diretamente\n"	;
			cout << "2 - Deseja saber mais informações sobre as tabelas?\n"	;
		}else if(estado == 1){
			system("cls");
			cout << "Modo Insercao:\n\n\n";
		}else if(estado == 2){
			system("cls");
			cout << "Modo Insercao:\n\n\n";
		}else{
			estado = MENU;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
	}

}

void func_atualizacao(){

}

void func_remocao(){

}

void func_selecao(){

}



int main(){

	int estado = 0;

	while(estado != -1){

		if(estado == 0){
			cout << "Olá, Bem vindo ao programa de conectividade com o Banco dos Heróis\n";
			cout << "Escolha qual uma das ações do menu:\n";
			cout << "1-\tEncerrar o Programa\n";
			cout << "2-\tInserção (Qualquer campo em uma Tabela)\n";
			cout << "3-\tAtualização (Qualquer campo em uma tabela)\n";
			cout << "4-\tRemover (Qualquer linha de uma tabela)\n";
			cout << "5-\tSeleção ()\n";
			cin >> estado;
		} else if(estado == ENCERRAR){
			cout << "Obrigado por escolher a nossa solução!\nAté a próxima!";
			estado = SAIR;
		} else if(estado == INSERCAO){
			func_insercao();
			estado = MENU;
		} else if(estado == ATUALIZACAO){
			func_atualizacao();
		 	estado = MENU;
		} else if(estado == REMOCAO){
			func_remocao();
			estado = MENU;
		} else if(estado == SELECAO) {
			func_selecao();
			estado = MENU;
		} else {
			estado = MENU;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
		
	}

	return 0;
}