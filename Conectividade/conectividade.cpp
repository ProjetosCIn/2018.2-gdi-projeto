// Incluindo todas as bibliotecas de C++
#include <bits/stdc++.h>

// Bibliotecas para a utilizacão da conexão com o ODBC
#include <stdio.h>
#include <sql.h>
#include <sqlext.h>
#include <sqltypes.h>

using namespace std;

#define MENU 0
#define ENCERRAR 1
#define INSERCAO 2
#define ATUALIZACAO 3
#define REMOCAO 4
#define SELECAO 5
#define SAIR - 1


void func_insercao(SQLHDBC dbc);
void func_atualizacao(SQLHDBC dbc);
void func_remocao(SQLHDBC dbc);
void func_selecao(SQLHDBC dbc);

void printaDadosTabela();

// Funcões de Acesso ao Banco
void sqlIUD(SQLHDBC *dbc, char *command);
void sqlSelect(SQLHDBC *dbc, char *command);

int main(){

	int estado = 0;

	// Variáveis para a conexão com o banco de dados
	SQLHENV env; // Handler do ambiente
	SQLHDBC dbc; // Driver do ODBC
	SQLHSTMT stmt; // Handler do Statement
	SQLRETURN ret; // Retorno de uma instrucão ao banco

	// Aloca um handle para o tipo do ambiente
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);

	// Com o ODBC 3 instalado, o ambiente é setado
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);

	// Aloca um handle do tipo connection
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);

	// Realizando a conexão ao banco de dados, aonde DSN é o Data Source Name, ou seja
	// O nome que foi setado para o banco
	SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=BancoDeHerois;", SQL_NTS,
               NULL, 0, NULL, SQL_DRIVER_COMPLETE);

	// Máquina de Estados da aplicacão Geral
	while(estado != -1){

		if(estado == MENU){
			cout << "Olá, Bem vindo ao programa de conectividade com o Banco dos Heróis\n";
			cout << "Escolha qual uma das acões do menu:\n";
			cout << "1-\tEncerrar o Programa\n";
			cout << "2-\tInsercão (Qualquer campo em uma Tabela)\n";
			cout << "3-\tAtualizacão (Qualquer campo em uma tabela)\n";
			cout << "4-\tRemover (Qualquer linha de uma tabela)\n";
			cout << "5-\tSelecão ()\n";
			cin >> estado;
		} else if(estado == ENCERRAR){
			cout << "Obrigado por escolher a nossa solucão!\nAté a próxima!";
			estado = SAIR;
		} else if(estado == INSERCAO){
			func_insercao(dbc);
			estado = MENU;
		} else if(estado == ATUALIZACAO){
			func_atualizacao(dbc);
		 	estado = MENU;
		} else if(estado == REMOCAO){
			func_remocao(dbc);
			estado = MENU;
		} else if(estado == SELECAO) {
			func_selecao(dbc);
			estado = MENU;
		} else {
			estado = MENU;
			cout << "Por favor, digite um valor válido\n\n\n";
		}	
	}

	return 0;
}

// Realiza uma execucão de instrucão no Banco de dados, onde o 2º argumento é o comando
// Usada para comandos onde não é necessário de retorno
void sqlIUD(SQLHDBC *dbc, char *command){
	SQLHSTMT stmt;
	SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
	SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
}

// Realiza o select em um tabela pré-determinada, como determinada na documentacão da ativdade. 
// A tabela pré-determinada escolhida foi a de personagem.
// Saída:
// Print(Nome das colunas)
// Print(Informacao das Linhas)
// Print(Numero de linhas retornadas)

void sqlSelect(SQLHDBC *dbc, char *command){
	int quantidadeLinhas = 0;

	// personagem= |codinome|frase_de_efeito|uniforme|endereco_de_nascimento|data_de_nascimento|
	SQLHSTMT stmt;
	SQLLEN indicator[5];
	SQLCHAR codinome[50]="";
	SQLCHAR frase_de_efeito[255]="";
	SQLCHAR uniforme[255]="";
	SQLCHAR endereco_de_nascimento[255]="";
	SQLDATE data_de_nascimento;
	stmt=NULL;
	SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
	SQLBindCol(stmt,1,SQL_C_CHAR,codinome,sizeof(codinome),&indicator[0]);
	SQLBindCol(stmt,2,SQL_C_CHAR,frase_de_efeito,sizeof(frase_de_efeito),&indicator[1]);
	SQLBindCol(stmt,3,SQL_C_CHAR,uniforme,sizeof(uniforme),&indicator[2]);
	SQLBindCol(stmt,4,SQL_C_CHAR,endereco_de_nascimento,sizeof(endereco_de_nascimento),&indicator[3]);
	SQLBindCol(stmt,5,SQL_DATE,&data_de_nascimento,sizeof(data_de_nascimento),&indicator[1]);
	SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
	cout << "Codinome\t\tFrase de Efeito\t\tUniforme\t\tEndereco de Nascimento\t\tData de Nascimento";
	while((SQLFetch(stmt)) != SQL_NO_DATA){
		cout << codinome << "\t\t" << frase_de_efeito << "\t\t" << uniforme << "\t\t" << endereco_de_nascimento << "\t\t" << data_de_nascimento << endl; 
		quantidadeLinhas++;
	}
	cout << "Numero de linhas retornadas: " << quantidadeLinhas << endl;
}

void printaDadosTabela(){
	cout << "As próximas linhas irão especificar cada coluna de cada uma das tabelas" << endl;
	cout << "lugar= |endereco|latitude|longitude|país|"<< endl;
	cout << "personagem= |codinome|frase_de_efeito|uniforme|endereco_de_nascimento|data_de_nascimento|" << endl;
	cout << "heroi= |codinome|crh|" << endl;
	cout << "vilao= |codinome|n_de_procurado|" << endl;
	cout << "mentor= |codinomementor|codinomementorado|" << endl;
	cout << "poder= |codigo_do_poder|nome|tipo|legalidade|" << endl;
	cout << "heroi_poder= |codinome|codigo_do_poder|" << endl;
	cout << "luta= |codinomeheroi|codinomevilao|" << endl;
	cout << "mentor= |endereco_da_luta|data_luta|" << endl;
	cout << "equipe= |codigo_de_equipe|n_de_fãs|" << endl;
	cout << "area_de_atuacao= |codigo_de_equipe|area|" << endl;
	cout << "qg= |codigo_de_equipe|n_de_qg|n_de_aposentos|CEP|" << endl;
	cout << "luta_envolve_equipe= |codinomeheroi|codinomevilao|endereco_da_luta|codigo_de_equipe|data_luta|" << endl;
	cout << "personagem_filiacão_equipe= |codigo_equipe|codinome|" << endl;
	cout << "simbolo= |codigo_de_equipe|significado|cor_predominante|id_imagem|" << endl;
}

void func_insercao(SQLHDBC dbc){
	system("cls");
	char *comando;
	int estado = 0;
	size_t tamanhoComando = 32;
	while(estado != -1){
		if(estado == 0){
			cout << "--- Modo Insercao:\n\n\n";
			cout << "Neste banco temos as tabelas:";
			cout << "|lugar|personagem|heroi|vilao|mentor|poder|\n \
					 |heroi_poder|luta|equipe|area_de_atuacao|qg|luta|\n \
					 |luta_envolve_equipe|personagem_filiacao_equipe|simbolo|\n\n";
			cout << "1 - Realizar a insercao diretamente\n"	;
			cout << "2 - Deseja saber mais informacões sobre as tabelas?\n"	;
			cin >> estado;
		}else if(estado == 1){
			system("cls");
			cout << "Digite a a sua insercão\n";
			cout << "Ex: \nINSERT INTO lugar(endereco, latitude, longitude, país) VALUES ('Rua dos testes, 321', 1111, 1111, 'Brasil')"<< endl;
			cout << "Obs: Não digite ; no final do seu comando" << endl;
			getline(&comando, &tamanhoComando, stdin);
			sqlIUD(&dbc, comando);
			cout << "\n\nO seu comando foi executado";
			estado = -1;
		}else if(estado == 2){
			system("cls");
			cout << "---Modo Insercao:\n\n\n";
			printaDadosTabela();
			cout << endl << "Digite 1 para realizar a insercão." << endl;
			cin >> estado;
			estado = -1;
		}else{
			estado = 0;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
	}
}

void func_atualizacao(SQLHDBC dbc){
	system("cls");
	char *comando;
	int estado = 0;
	size_t tamanhoComando = 32;
	while(estado != -1){
		if(estado == 0){
			cout << "--- Modo Atualizacão:\n\n\n";
			cout << "Neste banco temos as tabelas:";
			cout << "|lugar|personagem|heroi|vilao|mentor|poder|\n \
					 |heroi_poder|luta|equipe|area_de_atuacao|qg|luta|\n \
					 |luta_envolve_equipe|personagem_filiacao_equipe|simbolo|\n\n";
			cout << "1 - Realizar a atualizacão diretamente\n"	;
			cout << "2 - Deseja saber mais informacões sobre as tabelas?\n"	;
			cin >> estado;
		}else if(estado == 1){
			system("cls");
			cout << "Digite a sua Atualizacão\n";
			cout << "Ex: \nUPDATE personagem set codinome = 'Batman, o Melhor' WHERE codinome = 'Batman'"<< endl;
			cout << "Obs: Não digite ; no final do seu comando" << endl;
			getline(&comando, &tamanhoComando, stdin);
			sqlIUD(&dbc, comando);
			cout << "\n\nO seu comando foi executado";
			estado = -1;
		}else if(estado == 2){
			system("cls");
			cout << "---Modo Atualizacão:\n\n\n";
			printaDadosTabela();
			cout << endl << "Digite 1 para realizar a remocão." << endl;
			cin >> estado;
			estado = -1;
		}else{
			estado = 0;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
	}
}

void func_remocao(SQLHDBC dbc){
	system("cls");
	char *comando;
	int estado = 0;
	size_t tamanhoComando = 32;
	while(estado != -1){
		if(estado == 0){
			cout << "--- Modo Remocão:\n\n\n";
			cout << "Neste banco temos as tabelas:";
			cout << "|lugar|personagem|heroi|vilao|mentor|poder|\n \
					 |heroi_poder|luta|equipe|area_de_atuacao|qg|luta|\n \
					 |luta_envolve_equipe|personagem_filiacao_equipe|simbolo|\n\n";
			cout << "1 - Realizar a remocão diretamente\n"	;
			cout << "2 - Deseja saber mais informacões sobre as tabelas?\n"	;
			cin >> estado;
		}else if(estado == 1){
			system("cls");
			cout << "Digite a a sua remocão\n";
			cout << "Ex: \nDELETE FROM personagem WHERE codinome = 'bruxao'"<< endl;
			cout << "Obs: Não digite ; no final do seu comando" << endl;
			getline(&comando, &tamanhoComando, stdin);
			sqlIUD(&dbc, comando);
			cout << "\n\nO seu comando foi executado";
			estado = -1;
		}else if(estado == 2){
			system("cls");
			cout << "---Modo Remocão:\n\n\n";
			printaDadosTabela();
			cout << endl << "Digite 1 para realizar a remocão." << endl;
			cin >> estado;
			estado = -1;
		}else{
			estado = 0;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
	}
}

void func_selecao(SQLHDBC dbc){
	system("cls");
	char *comando;
	int estado = 0;
	size_t tamanhoComando = 32;
	while(estado != -1){
		if(estado == 0){
			cout << "--- Modo Selecao:\n\n\n";
			cout << "Neste banco temos as tabelas:";
			cout << "|lugar|personagem|heroi|vilao|mentor|poder|\n \
					 |heroi_poder|luta|equipe|area_de_atuacao|qg|luta|\n \
					 |luta_envolve_equipe|personagem_filiacao_equipe|simbolo|\n\n";
			cout << "1 - Realizar a selecao diretamente\n"	;
			cout << "2 - Deseja saber mais informacões sobre as tabelas?\n"	;
			cin >> estado;
		}else if(estado == 1){
			system("cls");
			cout << "Digite a a sua selecao\n";
			cout << "Ex: \nSELECT * from personagem WHERE codinome LIKE 'B%'"<< endl;
			cout << "Obs: Não digite ; no final do seu comando" << endl;
			getline(&comando, &tamanhoComando, stdin);
			sqlSelect(&dbc, comando);
			cout << "\n\nO seu comando foi executado";
			estado = -1;
		}else if(estado == 2){
			system("cls");
			cout << "---Modo Selecao:\n\n\n";
			printaDadosTabela();
			cout << endl << "Digite 1 para realizar a selecao." << endl;
			cin >> estado;
			estado = -1;
		}else{
			estado = 0;
			cout << "Por favor, digite um valor válido\n\n\n";
		}
	}
}