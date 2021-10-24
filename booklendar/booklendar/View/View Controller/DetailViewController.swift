//
//  DetailViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/13.
//

import UIKit

final class DetailViewController: UIViewController, ViewModelIncludable {
    
    // View
    private lazy var detailView = DetailView()

    private lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: .init(systemName: "arrowshape.turn.up.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTouched))
        return backButton
    }()
    
    private lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem(image: .init(systemName: "pencil"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(editButtonTouched))
        return editButton
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(image: .init(systemName: "checkmark"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTouched))
        return doneButton
    }()

    // View Model
    var viewModel: DetailViewModelType?
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialData()
    }
    
    private func configure() {
        view.backgroundColor = .white
        addDetailView()
        setNavigationButton()
    }

    private func addDetailView() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            detailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setNavigationButton() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setInitialData() {
        guard let details = viewModel?.initialData() else { return }
        detailView.configure(with: "2021. 10. 24", details.records[0].book)
    }
    
    @objc func backButtonTouched(_ sender: UIBarButtonItem) {
        viewModel?.editingFinished()
    }
    
    @objc func editButtonTouched(_ sender: UIBarButtonItem) {
        viewModel?.editStateChanged(to: .doing)
        navigationItem.rightBarButtonItem = doneButton
        detailView.searchMode(isOn: true)
    }
    
    @objc func doneButtonTouched(_ sender: UIBarButtonItem) {
        viewModel?.editStateChanged(to: .done)
        navigationItem.rightBarButtonItem = editButton
        detailView.searchMode(isOn: false)
    }
}
