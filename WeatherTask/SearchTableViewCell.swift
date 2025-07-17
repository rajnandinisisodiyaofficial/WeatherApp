//
//  SearchTableViewCell.swift
//  WeatherTask
//
//  Created by RajNandini on 16/07/25.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textFieldSearch : UITextField!
    @IBOutlet weak var buttonSubmit : UIButton!
    
    var searchCompletion: ((String?) -> Void)?
    var submitButtonClicked: (() -> Void)?
    var isEnableSubmitButton : Bool  = false{
        didSet{
            self.buttonSubmit.isEnabled = isEnableSubmitButton
            self.buttonSubmit.backgroundColor = isEnableSubmitButton ? .black : .gray
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension SearchTableViewCell {
    
    func setupUI(){
        textFieldSearch.addBorder(width: 1.0,color: .black, cornerRadius: textFieldSearch.frame.height/2)
        buttonSubmit.applyRoundedStyle()
        textFieldSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        backgroundColor = .clear
        contentView.backgroundColor = .clear

    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchCompletion?(textField.text?.lowercased())
        // Reload your tableView or collectionView
    }
    
    @IBAction func actionOnSubmitButton(_ button : UIButton){
        submitButtonClicked?()
    }
}
