//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Lucas Gabriel Salicano on 16/10/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes = [
        Refeicao(nome: "Macarrao", felicidade: 4),
        Refeicao(nome: "Sushi", felicidade: 1),
        Refeicao(nome: "Pizza", felicidade: 5),
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhe(_:)))
        
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    @objc func mostrarDetalhe(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).remover(refeicao, handler:  {
                alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    func adicionar(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
