//
//  ProfileViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/30/22.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    
    // Allows the current user to be passed in
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImageView: UIImageView = UIImageView()
    let profileName: UILabel = UILabel()
    let gradient: CAGradientLayer = CAGradientLayer()
    let questCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    var user: User?
    
    let posting1 = Posting(gigName: "Postering in Ctown", gigAmount: 40, profilePic: "joy", profileName: "Joy Dimen", gigDescription: "Need poster runner in ctown for 1-2 hours.", categoryName: "Labor", relevantSkills: "None", otherNotes: "N/A", favorite: false)
    let posting2 = Posting(gigName: "Research Study", gigAmount: 20, profilePic: "jocelyn", profileName: "Jocelyn Pearson", gigDescription: "Participate in our study to receive a personalized genetic ancestry report!", categoryName: "Research", relevantSkills: "None", otherNotes: "N/A", favorite: false)
    let posting4 = Posting(gigName: "Loading Furniture", gigAmount: 70, profilePic: "carson", profileName: "Carson Kotechi", gigDescription: "Local ithaca move moving two storage units", categoryName: "Labor", relevantSkills: "None", otherNotes: "N/A", favorite: true)
    let posting5 = Posting(gigName: "CS Tutoring", gigAmount: 15, profilePic: "jackchen", profileName: "Jack Chen", gigDescription: "I need help with my cs assignment for cs1110.", categoryName: "Tutoring", relevantSkills: "Computer Science", otherNotes: "N/A", favorite: true)
    
    let inProgressReuse = "progressReuseIdentifier"
    static let headerReuse = "headerReuseIdentifier"
    let favoriteReuse = "favoriteReuseIdentifier"

    var inProgress: [Posting] = []
    var favorites: [Posting] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add gradient background
        gradient.frame = self.view.bounds
        gradient.colors = [
            UIColor(rgb: 0xD8DFF2).cgColor, UIColor(rgb: 0xE1F8F8).cgColor
        ]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
        inProgress = [posting1, posting2]
        favorites = [posting4, posting5]
        
        // gets the profile image from the url provided by backend
        profileImageView.setImageFromStringrlL(url: user?.assets[0].url! ?? "")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        view.addSubview(profileImageView)
        
        profileName.text = "FirstName LastName"
        profileName.font = UIFont(name: "Merriweather-Regular", size: 20)
        profileName.textColor = UIColor(rgb: 0x435B99)
        profileName.backgroundColor = .clear
        view.addSubview(profileName)
        
        questCollectionView.register(InProgressCollectionViewCell.self, forCellWithReuseIdentifier: inProgressReuse)
        questCollectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: favoriteReuse)
        questCollectionView.register(Header.self, forSupplementaryViewOfKind: ProfileViewController.headerReuse, withReuseIdentifier: "headerID")
        questCollectionView.backgroundColor = .clear
        questCollectionView.dataSource = self
        view.addSubview(questCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        questCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    // Create a compositional layout
    static func createLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) ->
            NSCollectionLayoutSection? in
            
            
            // For "Tasks in Progress"
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(250)))
                item.contentInsets.trailing = 40
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)),
                    repeatingSubitem: item,
                    count: 1)
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 20
                section.contentInsets.bottom = 20
                section.orthogonalScrollingBehavior = .paging
                 //Creates a section header
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerReuse, alignment: .topLeading)
                ]
                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(200)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 25
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.4)),
                    repeatingSubitem: item,
                    count: 1)
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 20
                section.interGroupSpacing = 10
                 //Creates a section header
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerReuse, alignment: .topLeading)
                ]
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(50), heightDimension: .absolute(50)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? Header {
                header.label.text = "In Progress"
                header.label.backgroundColor = .clear
            }
        } else if indexPath.section == 1 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? Header {
                header.label.text = "Favorites"
                header.label.backgroundColor = .clear
            }
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? Header
        return header!
    }
}

class Header: UICollectionReusableView {
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = ""
        label.font = UIFont(name: "Merriweather-Regular", size: 24)
        label.textColor = UIColor(rgb: 0x435B99)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return inProgress.count
        } else if section == 1 {
            return favorites.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: inProgressReuse, for: indexPath) as? InProgressCollectionViewCell {
                cell.configure(posting: inProgress[indexPath.item])
                cell.contentView.backgroundColor = .white
                cell.contentView.layer.cornerRadius = 16
                cell.contentView.layer.shadowOpacity = 0.5
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
                cell.contentView.layer.shadowColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteReuse, for: indexPath) as? FavoritesCollectionViewCell {
                cell.configure(posting: favorites[indexPath.item])
                cell.contentView.backgroundColor = .white
                cell.contentView.layer.cornerRadius = 16
                cell.contentView.layer.shadowOpacity = 0.5
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
                cell.contentView.layer.shadowColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
        }
    }

