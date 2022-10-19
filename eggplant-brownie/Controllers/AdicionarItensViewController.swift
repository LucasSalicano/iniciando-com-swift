//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Lucas Gabriel Salicano on 18/10/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

protocol AdicionaItensDelegate {
    func adicionar(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    
    var delegate: AdicionaItensDelegate?
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Navigation
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text
        else { return }
        
        guard let numeroDeCalorias = Double(calorias) else { return }
        
        let item = Item(nome: nome, calorias: numeroDeCalorias)
        delegate?.adicionar(item)
        
        navigationController?.popViewController(animated: true)
    }
    
}
