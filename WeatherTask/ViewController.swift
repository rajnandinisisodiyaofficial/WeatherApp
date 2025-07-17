//
//  ViewController.swift
//  WeatherTask
//
//  Created by RajNandini on 15/07/25.
//

import UIKit
import Kingfisher
import Toast

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var weatherContainerView: UIView!
    @IBOutlet weak var iconContainerView: UIView!

    // MARK: - Properties
    var viewModel: ViewControllerViewModel!
    let refreshControl = UIRefreshControl()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerViewModel(controller: self)
        setupUI()
    }
}

// MARK: - UI Setup
extension ViewController {

    func setupUI() {
        configureNavigationBar()
        configureTableView()
        updateWeatherView()
        iconContainerView.circular()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
            UITableView.appearance().sectionHeaderTopPadding = 0.0
            UITableView.appearance().sectionFooterHeight = 0.0
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "Find Weather For Your City"
    }

    func configureTableView() {
        tableView.registerCell(CityNameTableViewCell.self)
        tableView.registerCell(SearchTableViewCell.self)

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        tableView.backgroundColor = .clear
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.separatorStyle = .none
    }

    @objc func handleRefresh() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewModel.fetchWeather()
        }
    }

    func updateWeatherView() {
        guard let data = viewModel.selectedCityWeather else {
            weatherContainerView.isHidden = true
            return
        }
        weatherContainerView.isHidden = false
        let iconURLString = APIManager.shared.imageBaseURL + (data.weather.first?.icon ?? "") + "@2x.png"
        weatherIconImageView.kf.setImage(with: URL(string: iconURLString))
        weatherConditionLabel.text = data.weather.first?.main
        temperatureLabel.text = data.main.temp.celsiusString
        dateLabel.text = Date.currentFormattedDate()
        timeLabel.text = Date.currentFormattedTime()
        weatherIconImageView.tintColor = .systemBlue
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel.filteredCities.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return configureSearchCell(for: indexPath)
        case 1: return configureCityCell(for: indexPath)
        default: return UITableViewCell()
        }
    }

    private func configureSearchCell(for indexPath: IndexPath) -> SearchTableViewCell {
        let cell = tableView.dequeueCell(SearchTableViewCell.self, for: indexPath)
        cell.textFieldSearch.text = viewModel.selectedCity?.name
        cell.isEnableSubmitButton = viewModel.selectedCity != nil

        cell.searchCompletion = { [weak self] query in
            guard let self = self else { return }
            cell.isEnableSubmitButton = false
            if let query = query, !query.isEmpty {
                self.viewModel.filteredCities = self.viewModel.allCities.filter {
                    $0.name.lowercased().contains(query.lowercased())
                }
            } else {
                self.viewModel.filteredCities = []
            }
        }

        cell.submitButtonClicked = { [weak self] in
            self?.viewModel.fetchWeather()
        }

        return cell
    }

    private func configureCityCell(for indexPath: IndexPath) -> CityNameTableViewCell {
        let cell = tableView.dequeueCell(CityNameTableViewCell.self, for: indexPath)
        cell.labelCityName.text = viewModel.filteredCities[indexPath.row].name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 55.0
        case 1: return 45.0
        case 2: return UITableView.automaticDimension
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            viewModel.selectedCity = viewModel.filteredCities[indexPath.row]
            viewModel.filteredCities = []
        }
    }
}

