//
//  CityNameTableViewCell.swift
//  WeatherTask
//
//  Created by RajNandini on 16/07/25.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCityName : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
