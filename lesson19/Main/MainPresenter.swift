//
//  MainPresenter.swift
//  lesson19
//
//  Created Vladislav on 22.09.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation


// MARK: Presenter -
protocol MainPresenterProtocol {
	var view: MainViewProtocol? { get set }
    func viewDidLoad()
    
    func addNewText(text: String)
    func removeText(for indexPath: IndexPath)
    
    func numberOfElementsInTextArray() -> Int
    func elementInTextArray(for indexPath: IndexPath) -> String
}

class MainPresenter: MainPresenterProtocol {
    private var textArray: [String] = []
    
    weak var view: MainViewProtocol?

    func viewDidLoad() {

    }
    
    func removeText(for indexPath: IndexPath) {
        textArray.remove(at: indexPath.row)
        view?.removeElementFromTableView(to: indexPath)
    }
    
    func addNewText(text: String) {
        textArray.append(text)
        view?.addElementToTableView(
            to: IndexPath(
                row: numberOfElementsInTextArray() - 1,
                section: 0
            )
        )
    }
    
    func numberOfElementsInTextArray() -> Int {
        return textArray.count
    }
    
    func elementInTextArray(for indexPath: IndexPath) -> String {
        return textArray[indexPath.row]
    }
}
