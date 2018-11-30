//
//  NewsTableViewController.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import SafariServices

class NewsTableViewController: UITableViewController {
    
    private var page = 1
    
    var news: News? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        setupTableView()
        fetchNews()
    }
    
    func setupTableView() {
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func fetchNews() {
        News.get(page: 1, pageSize: 20) { (news) in
            self.news = news
        }
    }
    
    func setupViews() {
        view.backgroundColor = ThemeManager.themeWhite
    }
    
    func setupNavigation() {
        self.title = "Singapore News"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news?.articles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsTableViewCell
        cell.article = self.news?.articles[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let urlString = self.news?.articles[indexPath.item].url {
            openLink(urlString: urlString)
        }
    }
    
    func openLink(urlString: String) {
        
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}

class NewsTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ThemeManager.themeBlack
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = ThemeManager.themeGray
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ThemeManager.themeGray
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, sourceLabel, summaryLabel, dateLabel])
        view.axis = .vertical
        view.spacing = 8
        view.distribution = UIStackView.Distribution.fill
        return view
    }()
    
    var article: Article! {
        didSet {
            updateViews()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        
        addSubview(newsImageView)
        addSubview(stackView)
        
        newsImageView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.trailing.equalTo(snp.trailing).offset(-16)
            make.top.equalTo(snp.top).offset(16)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(16)
            make.leading.equalTo(snp.leading).offset(16)
            make.bottom.equalTo(snp.bottom).offset(-16)
            make.trailing.equalTo(newsImageView.snp.leading).offset(-16)
        }
    }
    
    func updateViews() {
        newsImageView.setImage(urlString: article.urlToImage)
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        summaryLabel.text = article.description ?? article.content
        
        if let date = article.publishedAt.iso8601 {
            let formattedDateString = date.toNewsFormat()
            dateLabel.text = formattedDateString
        }
    }
}
