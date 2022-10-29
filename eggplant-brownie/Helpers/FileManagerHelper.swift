//
//  FileManager.swift
//  eggplant-brownie
//
//  Created by Lucas Gabriel Salicano on 29/10/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class FileManagerHelper {
    
    // MARK: - Recupera ou cria diretório
    func recuperaDiretorio(pastaNome: String) -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        return diretorio.appendingPathComponent(pastaNome)
    }
    
}
