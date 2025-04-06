#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import questionary
# from collections.abc import Mapping


def encontrar_arquivos_desktop():
    """
    Retorna uma lista de todos os arquivos .desktop
    encontrados nos diretórios mais comuns.
    """
    diretorios = [
        "/usr/share/applications",
        os.path.expanduser("~/.local/share/applications"),
        "/usr/local/share/applications"
    ]
    
    arquivos_encontrados = []
    for d in diretorios:
        if os.path.exists(d):
            for arquivo in os.listdir(d):
                if arquivo.endswith(".desktop"):
                    caminho_completo = os.path.join(d, arquivo)
                    arquivos_encontrados.append(caminho_completo)
    return arquivos_encontrados

def listar_arquivos(arquivos):
    """
    Lista (imprime) os arquivos .desktop no terminal.
    """
    if not arquivos:
        print("\nNenhum arquivo .desktop encontrado.")
        return
    print("\n==== ARQUIVOS .DESKTOP ENCONTRADOS ====")
    for i, arq in enumerate(arquivos, start=1):
        print(f"{i}. {arq}")
    print("========================================\n")

def buscar_por_nome(arquivos):
    """
    Permite ao usuário digitar um termo e filtra
    os arquivos que contêm esse termo (maiúsculo ou minúsculo).
    """
    if not arquivos:
        print("Não há arquivos para buscar.")
        return
    
    termo = questionary.text('Digite o termo para pesquisa (ou deixe vazio para cancelar):').ask()
    
    if not termo:
        print("Busca cancelada.")
        return
    
    termo = termo.strip().lower()
    resultados = [a for a in arquivos if termo in os.path.basename(a).lower()]
    
    if resultados:
        listar_arquivos(resultados)
    else:
        print("Nenhum arquivo encontrado com esse termo.")

def deletar_arquivo(arquivos):
    """
    Lista arquivos e pergunta qual deseja deletar.
    """
    if not arquivos:
        print("\nNão há arquivos .desktop para deletar.")
        return
    
    arquivo_escolhido = questionary.select(
        'Selecione o arquivo que deseja excluir:',
        choices=arquivos
    ).ask()
    
    if not arquivo_escolhido:
        print("Nenhum arquivo selecionado.")
        return
    
    confirmar = questionary.confirm(
        f"Tem certeza de que deseja excluir '{arquivo_escolhido}'?",
        default=False
    ).ask()
    
    if confirmar:
        try:
            os.remove(arquivo_escolhido)
            print(f"Arquivo '{arquivo_escolhido}' excluído com sucesso.")
        except PermissionError:
            print(f"Permissão negada para excluir '{arquivo_escolhido}'. Tente rodar o script com sudo.")
        except Exception as e:
            print(f"Erro ao excluir o arquivo: {e}")
    else:
        print("Exclusão cancelada.")

def menu_principal():
    """
    Exibe um menu interativo com questionary.
    """
    while True:
        arquivos = encontrar_arquivos_desktop()
        
        acao = questionary.select(
            'O que deseja fazer?',
            choices=[
                'Listar arquivos .desktop',
                'Buscar por nome',
                'Deletar um arquivo .desktop',
                'Sair'
            ]
        ).ask()
        
        if acao == 'Listar arquivos .desktop':
            listar_arquivos(arquivos)
        elif acao == 'Buscar por nome':
            buscar_por_nome(arquivos)
        elif acao == 'Deletar um arquivo .desktop':
            deletar_arquivo(arquivos)
        elif acao == 'Sair':
            print("Saindo do programa.")
            break
        else:
            print("Opção inválida. Tente novamente.\n")

if __name__ == "__main__":
    menu_principal()
