//
//  RefeicaoDAO.swift
//  eggplant-brownie
//
//  Created by Lucas Gabriel Salicano on 29/10/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import Foundation

class RefeicaoDAO {
    
    var refeicoes: [Refeicao] = []
    
    init() {
        refeicoes = self.findAll() ?? []
    }
    
    func save(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        atualizaBase()
    }
    
    func getRefeicaoById(_ id: Int) -> Refeicao {
        return refeicoes[id]
    }
    
    func findAll() -> [Refeicao]? {
        guard let caminho = FileManagerHelper().recuperaDiretorio(pastaNome: "refeicao") else { return nil }
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return nil }
            refeicoes = refeicoesSalvas
        } catch {
            print(error.localizedDescription)
        }
        
        return refeicoes
    }
    
    func remove(_ id: Int) {
        refeicoes.remove(at: id)
        atualizaBase()
    }
    
    func atualizaBase() {
        guard let caminho = FileManagerHelper().recuperaDiretorio(pastaNome: "refeicao") else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
}
