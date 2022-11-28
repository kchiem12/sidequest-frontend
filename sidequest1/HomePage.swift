//
//  HomePage.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/21/22.
//

import UIKit
import SnapKit

class HomePage: UIViewController {

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

    // Set Up Collection Objects for Filter
    let researchStudies = Joba(jobCategoryName: "Research")
    let entertainment = Joba(jobCategoryName: "Entertainment")
    let labor = Joba(jobCategoryName: "Labor")
    let tutoring = Joba(jobCategoryName: "Tutoring")
    let petsitting = Joba(jobCategoryName: "Pet Sitting")
    var jobs: [Joba] = []

    // Set Up CollectionView Var
    var filterCollectionView: UICollectionView!
    let spacing1: CGFloat = 15
    let jobReuseIdentifier: String = "jobReuseIdentifier"

    // Set Up Collection Objects for Job Postings
    let posting1 = Posting(gigName: "Postering in Ctown", gigAmount: 40, profilePic: "joy", profileName: "Joy Dimen", gigDescription: "Need poster runner in ctown for 1-2 hours.")
    let posting2 = Posting(gigName: "Research Study", gigAmount: 20, profilePic: "jocelyn", profileName: "Jocelyn Pearson", gigDescription: "Participate in our study to receive a personalized genetic ancestry report!")
    let posting3 = Posting(gigName: "DJ for ISU Party", gigAmount: 30, profilePic: "danielwong", profileName: "Daniel Wong", gigDescription: "We need a DJ tomorrow for our party. Must be 21+.")
    let posting4 = Posting(gigName: "Loading Furniture", gigAmount: 70, profilePic: "carson", profileName: "Carson Kotechi", gigDescription: "Local ithaca move moving two storage units")
    let posting5 = Posting(gigName: "CS Tutoring", gigAmount: 15, profilePic: "jackchen", profileName: "Jack Chen", gigDescription: "I need help with my cs assignment for cs1110.")

    var postings: [Posting] = []

    // Set Up CollectionView var
    var postingCollectionView: UICollectionView!
    let spacing2: CGFloat = 15
    let postingReuseIdentifier: String = "postingReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav Bar Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.491, green: 0.57, blue: 0.771, alpha: 1)
        navigationItem.standardAppearance = appearance;
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance

        // Title
        navigationItem.title = "SideQuest"

        // Chat Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: chatBubble, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black

        // Background Color
        view.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Collection Objects in Arrays
        jobs = [researchStudies, entertainment, labor, tutoring, petsitting]
        postings = [posting1, posting2, posting3, posting4, posting5]


        // Set Up Properties

        // FilterTextField
        filterTextField.backgroundColor = .white
        filterTextField.attributedPlaceholder = NSAttributedString(string: "Search for gigs...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)])
        filterTextField.textAlignment = NSTextAlignment.left
        filterTextField.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        filterTextField.font = .systemFont(ofSize: 15)
        filterTextField.layer.cornerRadius = 12
        view.addSubview(filterTextField)

        // Filter Collection View
        // Setup flow layout
        let jobLayout = UICollectionViewFlowLayout()
        jobLayout.minimumInteritemSpacing = spacing1
        jobLayout.scrollDirection = .horizontal

        // Instantiate collection view
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: jobLayout)
        filterCollectionView.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Set collection view data source
        filterCollectionView.dataSource = self

        // Set collection view delegate
        filterCollectionView.delegate = self

        // Register view
        filterCollectionView.register(JobCollectionViewCell.self, forCellWithReuseIdentifier: jobReuseIdentifier)
        view.addSubview(filterCollectionView)

        // Posting Collection View
        // Setup flow layout
        let postingLayout = UICollectionViewFlowLayout()
        postingLayout.minimumLineSpacing = spacing2
        postingLayout.scrollDirection = .vertical

        // Instantiate collection view
        postingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postingLayout)
        postingCollectionView.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Set collection view data source
        postingCollectionView.dataSource = self

        // Set collection view delegate
        postingCollectionView.delegate = self

        // Register collection view
        postingCollectionView.register(PostingCollectionViewCell.self, forCellWithReuseIdentifier: postingReuseIdentifier)
        view.addSubview(postingCollectionView)


        // Set Up Constraints
        filterTextField.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(110)
            make.width.equalTo(355)
            make.height.equalTo(38)
        }

        filterCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(filterTextField.snp.bottom).offset(12)
            make.left.equalTo(filterTextField.snp.left)
            make.right.equalTo(self.view)
            make.bottom.equalTo(filterTextField.snp.bottom).offset(70)
        }

        postingCollectionView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(filterTextField.snp.left)
            make.right.equalTo(filterTextField.snp.right)
            make.top.equalTo(filterCollectionView.snp.bottom).offset(20)
            make.bottom.equalTo(self.view)
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
                cell2.configure(posting: postings[indexPath.row])
                cell2.contentView.backgroundColor = UIColor.white
                cell2.contentView.layer.cornerRadius = 16
                cell2.contentView.layer.shadowOpacity = 0.5
                cell2.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
                cell2.contentView.layer.shadowColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
                return cell2
            }
            else {
                return UICollectionViewCell()
            }
        }

        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: jobReuseIdentifier, for: indexPath) as? JobCollectionViewCell{
            cell1.configure(job: jobs[indexPath.row])
            return cell1
        }
        else {
            return UICollectionViewCell()
        }
    }
}

// Confrom to UICollectionViewDelegateFlowLayout
extension HomePage: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == postingCollectionView) {
            return CGSize(width: 358, height: 164)
        }

        return CGSize(width: 120, height: 42)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == postingCollectionView) {
            present(moreInfoPresentViewController(posting: postings[indexPath.item]), animated: true)
        }
    }
}



