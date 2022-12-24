//
//  HomePage.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/21/22.
//

import UIKit
import SnapKit

class HomePage: UIViewController {

    // Adds padding to textfield
    class TextFieldWithPadding: UITextField {
        var textPadding = UIEdgeInsets(
            top: 10,
            left: 20,
            bottom: 10,
            right: 20
        )

        override func textRect(forBounds bounds: CGRect) -> CGRect {
                let rect = super.textRect(forBounds: bounds)
                return rect.inset(by: textPadding)
            }

            override func editingRect(forBounds bounds: CGRect) -> CGRect {
                let rect = super.editingRect(forBounds: bounds)
                return rect.inset(by: textPadding)
            }
    }

    // Set Up Variables
    let filterTextField = TextFieldWithPadding()
    let chatBubble = UIImage(named: "chatbubble")
    let resultNumberLabel = UILabel()
    
    let refreshControl = UIRefreshControl()
    

    // Set Up Collection Objects for Filter
    let researchStudies = Filter(jobCategoryName: "Research", isSelected: false)
        let entertainment = Filter(jobCategoryName: "Entertainment", isSelected: false)
        let labor = Filter(jobCategoryName: "Labor", isSelected: false)
        let tutoring = Filter(jobCategoryName: "Tutoring", isSelected: false)
        let petsitting = Filter(jobCategoryName: "Pet Sitting", isSelected: false)
        var jobs: [Filter] = []
    var user: User
    var chatImage = UIImage(named: "Send-2")?.withRenderingMode(.alwaysOriginal)
    
    
    
    // Initializes the user in HomePage
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set Up CollectionView var for filter
    var filterCollectionView: UICollectionView!
    let spacing1: CGFloat = 15
    let jobReuseIdentifier: String = "jobReuseIdentifier"
    
//    var numberPostings = 0

    
    // Set Up Collection Objects for Job Postings (hard coded data)
    let posting1 = Posting(gigName: "Postering in Ctown", gigAmount: "40.00", profilePic: "joy", profileName: "Joy Dimen", gigDescription: "Need poster runner in ctown for 1-2 hours.", categoryName: "Labor", relevantSkills: "None", otherNotes: "N/A", favorite: false, job: nil)
    let posting2 = Posting(gigName: "Research Study", gigAmount: "20.00", profilePic: "jocelyn", profileName: "Jocelyn Pearson", gigDescription: "Participate in our study to receive a personalized genetic ancestry report!", categoryName: "Research", relevantSkills: "None", otherNotes: "N/A", favorite: false, job: nil)
    let posting3 = Posting(gigName: "DJ for ISU Party", gigAmount: "30.00", profilePic: "danielwong", profileName: "Daniel Wong", gigDescription: "We need a DJ tomorrow for our party. Must be 21+.", categoryName: "Entertainment", relevantSkills: "Music", otherNotes: "N/A", favorite: false, job: nil)
    let posting4 = Posting(gigName: "Loading Furniture", gigAmount: "70.00", profilePic: "carson", profileName: "Carson Kotechi", gigDescription: "Local ithaca move moving two storage units", categoryName: "Labor", relevantSkills: "None", otherNotes: "N/A", favorite: false, job: nil)
    let posting5 = Posting(gigName: "CS Tutoring", gigAmount: "15.00", profilePic: "jackchen", profileName: "Jack Chen", gigDescription: "I need help with my cs assignment for cs1110.", categoryName: "Tutoring", relevantSkills: "Computer Science", otherNotes: "N/A", favorite: false, job: nil)

    // Postings array to contain all Posting objects
    var allPostings: [Posting] = []
    var postings: [Posting] = []

    // Set Up CollectionView var for postings
    var postingCollectionView: UICollectionView!
    let spacing2: CGFloat = 15
    let postingReuseIdentifier: String = "postingReuseIdentifier"
    
    // Displays the logo on the top left of screen
    let navigationImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets the top left of the screen as the logo
        navigationImageView.image = UIImage(named: "navigation title")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navigationImageView)
        
        // Nav Bar Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.491, green: 0.57, blue: 0.771, alpha: 1)
        navigationItem.standardAppearance = appearance;
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance

        // Chat Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: chatBubble, style: .plain, target: self, action: #selector(pushMessages))
        navigationItem.rightBarButtonItem?.tintColor = .black

        // Background Color
        view.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Collection Objects for filter array
        jobs = [researchStudies, entertainment, labor, tutoring, petsitting]
       
        getPosts() // to populate the screen with postings from the database
        
        // Adds the chat icon on the top right
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: chatImage, style: .plain, target: self, action: #selector(presentMessages))]

        //---- Set Up Properties ----

        // FilterTextField
        filterTextField.backgroundColor = .white
        filterTextField.attributedPlaceholder = NSAttributedString(string: "Search for gigs...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)])
        filterTextField.textAlignment = NSTextAlignment.left
        filterTextField.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        filterTextField.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        filterTextField.layer.cornerRadius = 12
        view.addSubview(filterTextField)
        
        // ResultNumberLabel
        // TODO: Make it so this displays the number of Postings on the homescreen
//        resultNumberLabel.text = "\(self.postings.count) results"
        resultNumberLabel.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        resultNumberLabel.font = .systemFont(ofSize: 16)
        view.addSubview(resultNumberLabel)

        // Filter Collection View
        // Setup flow layout
        let jobLayout = UICollectionViewFlowLayout()
        jobLayout.minimumInteritemSpacing = spacing1
        jobLayout.scrollDirection = .horizontal

        // Instantiate filter collection view
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: jobLayout)
        filterCollectionView.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Set filter collection view data source
        filterCollectionView.dataSource = self

        // Set filter collection view delegate
        filterCollectionView.delegate = self

        // Register the cells to the collection view
        filterCollectionView.register(JobCollectionViewCell.self, forCellWithReuseIdentifier: jobReuseIdentifier)
        
        view.addSubview(filterCollectionView)

        // Posting Collection View
        // Setup flow layout
        let postingLayout = UICollectionViewFlowLayout()
        postingLayout.minimumLineSpacing = spacing2
        postingLayout.scrollDirection = .vertical

        // Instantiate posting collection view
        postingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postingLayout)
        postingCollectionView.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)
        
        // Setup action for refresh control
        refreshControl.addTarget(self, action: #selector(refreshPostings(_:)), for: .valueChanged)
        
        // Add refresh control to collection view
        if #available(iOS 10.0, *) {
            postingCollectionView.refreshControl = refreshControl
        } else {
            postingCollectionView.addSubview(refreshControl)
        }

        // Set posting collection view data source
        postingCollectionView.dataSource = self

        // Set posting collection view delegate
        postingCollectionView.delegate = self

        // Register posting collection view cell
        postingCollectionView.register(PostingCollectionViewCell.self, forCellWithReuseIdentifier: postingReuseIdentifier)
        view.addSubview(postingCollectionView)


        setupConstraints()
    }
    
    // Sets up the constraints
    fileprivate func setupConstraints() {
        
        filterTextField.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(12)
            make.width.equalTo(359)
            make.height.equalTo(42)
        }
        
        filterCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(filterTextField.snp.bottom).offset(10)
            make.left.equalTo(filterTextField.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(filterTextField.snp.bottom).offset(52)
        }
        
        resultNumberLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(filterCollectionView.snp.bottom).offset(20)
            make.left.equalTo(filterCollectionView.snp.left).offset(10)
        }
        
        postingCollectionView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(filterTextField.snp.left)
            make.right.equalTo(filterTextField.snp.right)
            make.top.equalTo(resultNumberLabel.snp.bottom).offset(6)
            make.bottom.equalTo(self.view)
        }
    }
    
    // presents a message view
    @objc func presentMessages() {
        navigationController?.pushViewController(MessageViewController(), animated: true)
    }
    
    // pushes message view controller when the chat icon is tapped on
    @objc func pushMessages() {
        navigationController?.pushViewController(MessageViewController(), animated: true)
    }
    
    // refreshes the posting collection view
    @objc func refreshPostings(_ sender: Any) {
        DispatchQueue.main.async {
            self.getPosts()
        }
    }

    
    // gets every posts
    func getPosts() {
        var posts: [Posting] = []
        
        NetworkManager.getAllPosts { jobs in
            for job in jobs.jobs {

                // to safely unwrap values
                if let reward = job.reward, let picture = (job.asset.count == 0 ? "profile_placeholder" : job.asset[0].url) {
                    let post = Posting(gigName: job.title, gigAmount: reward, profilePic: picture, profileName: job.poster[0].first! + " " + job.poster[0].last!, gigDescription: job.description, categoryName: job.category, relevantSkills: "", otherNotes: "", favorite: false, job: job)
                    posts.insert(post, at: 0)
                } else {
                    print("One of the jobs has invalid information")
                }
            }
            
            // Add in hardcoded data alongside posts from database
            self.postings = [self.posting1, self.posting2, self.posting3, self.posting4, self.posting5]
            self.allPostings = self.postings
            self.postings.insert(contentsOf: posts, at: 0)
            self.allPostings.insert(contentsOf: posts, at: 0)
//            self.numberPostings = self.allPostings.count
            self.resultNumberLabel.text = "\(self.allPostings.count) results"
            self.postingCollectionView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
}


// Conform to UICollectionViewDataSource
extension HomePage: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == postingCollectionView) {
            return postings.count
        }
        return jobs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == postingCollectionView) {
            if let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: postingReuseIdentifier, for: indexPath) as? PostingCollectionViewCell {
                cell2.configure(posting: postings[indexPath.item])
                cell2.contentView.backgroundColor = UIColor.white
                cell2.contentView.layer.cornerRadius = 16
                cell2.contentView.layer.shadowOpacity = 0.5
                cell2.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
                cell2.contentView.layer.shadowColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
                return cell2
            }
        } else if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: jobReuseIdentifier, for: indexPath) as? JobCollectionViewCell{
            cell1.configure(job: jobs[indexPath.item])
            return cell1
        }
        return UICollectionViewCell()
    }
}

// Confrom to UICollectionViewDelegateFlowLayout
extension HomePage: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // TODO: Refactor and cut/make this neater
        
        if (collectionView == postingCollectionView) {
            return CGSize(width: 353, height: 162)
        } else {
            let item = jobs[indexPath.row].jobCategoryName
            return CGSize(width: item.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)]).width + 5, height: 42)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == filterCollectionView) {
            postings = []
            
            jobs[indexPath.item].isSelected.toggle()
            
            if(jobs[0].isSelected) {
                postings = postings + allPostings.filter({ posting in
                    posting.categoryName == "Research"
                })
            }
            
            if(jobs[1].isSelected) {
                postings = postings + allPostings.filter({ posting in
                    posting.categoryName == "Entertainment"
                })

            }
            
            if(jobs[2].isSelected) {
                postings = postings + allPostings.filter({ posting in
                    posting.categoryName == "Labor"
                })
            }
            
            if(jobs[3].isSelected) {
                postings = postings + allPostings.filter({ posting in
                    posting.categoryName == "Tutoring"
                })
            }
            
            if(jobs[4].isSelected) {
                postings = postings + allPostings.filter({ posting in
                    posting.categoryName == "Pet Sitting"
                })
            }
            
            if(jobs[0].isSelected == jobs[1].isSelected && jobs[0].isSelected == jobs[2].isSelected && jobs[0].isSelected == jobs[3].isSelected && jobs[0].isSelected == jobs[4].isSelected && jobs[1].isSelected == jobs[2].isSelected && jobs[1].isSelected == jobs[3].isSelected && jobs[1].isSelected == jobs[4].isSelected && jobs[2].isSelected == jobs[3].isSelected && jobs[2].isSelected == jobs[4].isSelected && jobs[3].isSelected == jobs[4].isSelected) {
                                postings = allPostings
                    }
            
            postingCollectionView.reloadData()
            collectionView.reloadData()
            self.resultNumberLabel.text = "\(self.postings.count) results"
            
        }
        
        if (collectionView == postingCollectionView) {
            present(moreInfoPresentViewController(posting: postings[indexPath.item], user: user), animated: true)
        }
        
    }
}






