//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Andriu Felipe Coelho on 23/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func adicionar(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    var itens:  [Item] = [
        Item(nome: "Item 1", calorias: 100.0),
        Item(nome: "Item 2", calorias: 130.0)
    ]

    
    @IBOutlet weak var tableViewItens: UITableView?
    
    var itensSelecionados: [Item] = []
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            
            let linhaTabela = indexPath.row
            itensSelecionados.append(itens[linhaTabela]
            )
        } else {
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let posicao = itensSelecionados.index(of: item) {
                itensSelecionados.remove(at: posicao)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let item = itens[indexPath.row]
        celula.textLabel?.text = item.nome
        return celula
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        
        navigationItem.rightBarButtonItem = botaoAdicionaItem
    }
    
 
    func adicionar(_ item: Item) {
        itens.append(item)
        
        if let tableViewItens = tableViewItens {
            tableViewItens.reloadData()
        } else {
            Alert(controller: self).show(title: "Erro", message: "Não foi possivel atualizar a tabela de itens.")
        }
    }
    
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    
    @IBAction func adicionar(_ sender: Any) {
        
        guard let refeicao = getRefeicaoFormulario() else {
            Alert(controller: self).show(title: "Atencao", message: "Erro ao recuperar refeicao do formulario.")
            return
        }
        
        if let delegate = delegate {
            delegate.adicionar(refeicao)
        } else {
            Alert(controller: self).show(title: "Atencao", message: "Erro ao recuperar delegate.")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func getRefeicaoFormulario() -> Refeicao? {
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao), let nomeDaRefeicao = nomeTextField?.text else {
            Alert(controller: self).show(title: "Atencao", message: "Campos dos formulario esta com valores invalidos.")
            return nil
        }
        
        return Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itens)
    }
}

