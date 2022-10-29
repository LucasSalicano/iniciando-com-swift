//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Lucas Gabriel Salicano on 29/10/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import Foundation
import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func remover(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
        alerta.addAction(botaoCancelar)
        
        let botaoRemover = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        alerta.addAction(botaoRemover)
        
        self.controller.present(alerta, animated: true, completion: nil)
    }
    
}
