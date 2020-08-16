//
//  HomeViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Charts
import FirebaseFirestore

class CoupleDetailViewController : UIViewController {
    
    lazy var headerView = DetailHeaderView(couple: couple)
    lazy var chartView = ChartsView(couple: couple)
    
    let couple : Couple
    
    var comments = [Comment]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var lastDocument : DocumentSnapshot?
    
    var voted = false
    
    private var tableView = UITableView()
    
    init(couple : Couple) {
        self.couple = couple
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .black
        configureUI()
        configureTV()
        
        checkVoted()
        fetchComments()
        
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.addSubview(headerView)
        headerView.anchor(top : view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor, right: view.rightAnchor,width: view.frame.width,height: 200)
        
        headerView.delegate = chartView
    }
    
    private func configureTV() {
        
        chartView.delegate = self
        
        tableView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.tableHeaderView = chartView
        chartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        /// section1
        tableView.register(AddCommentCell.self, forCellReuseIdentifier: AddCommentCell.identifier)
        
        /// section2
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.contentOffset.y = -70
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 350, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 350, right: 0)
        

        view.addSubview(tableView)
        
        
    }
    
    //MARK: - configure footer
    
    private func configureFootter() {
        
        let footer = UIView(frame: .zero)
        
        if comments.count >= 5 && comments.count % 5 == 0 {
            
            let moreButton = createMoreButton()

            footer.addSubview(moreButton)
            moreButton.center(inView: footer)
            
            footer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        }
        
        tableView.tableFooterView = footer
    }
    
    //MARK: - API
    
    private func checkVoted() {
        CoupleService.checkVoted(couple: couple) { (voted) in
            
            self.voted = voted
            self.headerView.voted = voted

        }
    }
    
    private func fetchComments() {
        CoupleService.fetchComments(couple: couple, isInitial: true, limit: 5, lastDocument: nil) { (comments, error, lastDocument) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self.comments = comments
            self.lastDocument = lastDocument
            
            self.configureFootter()
   
        }
    }
    
    /// pagination
    
    @objc func handleMore() {
        guard let lastDocument = lastDocument else {return}
        
        self.navigationController?.showPresentLoadindView(true)

        
        CoupleService.fetchComments(couple: couple, isInitial: false, limit: 5, lastDocument: lastDocument) { (comments, error, lastDoc) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.navigationController?.showPresentLoadindView(false)

                return
            }
            
            self.comments.append(contentsOf: comments)
            self.lastDocument = lastDoc
            
            self.configureFootter()
            
            self.navigationController?.showPresentLoadindView(false)


        }
    }
    
    //MARK: - helper
    
    private func createMoreButton() -> UIButton {
        
        let moreButton = UIButton(type: .system)
        moreButton.backgroundColor = .clear
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = UIColor.white.cgColor
        moreButton.setTitle("Show More", for: .normal)
        moreButton.setTitleColor(.white, for: .normal)
        moreButton.clipsToBounds = true
        moreButton.layer.cornerRadius = 13 / 2
        moreButton.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        moreButton.setDimensions(height: 50, width: 100)
        
        return moreButton
    }
}

extension CoupleDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1 :
            return comments.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var addCell : AddCommentCell!
        var commentCell  : CommentCell!
        var cell : UITableViewCell!
        
        switch indexPath.section {
        case 0:
            addCell = tableView.dequeueReusableCell(withIdentifier: AddCommentCell.identifier, for: indexPath) as? AddCommentCell
            
            addCell.delegate = self
            return addCell
            
        case 1 :
            commentCell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell
            
            commentCell.comment = comments[indexPath.row]
            
            return commentCell
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
        
      
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 150
        default:
            let text = comments[indexPath.row].text
            var height: CGFloat
            
            height = estimatedFrameForText(text: text).height + 30
            return height
        }
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: view.frame.width, height: 250)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
       
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "新しいコメント"
        case 1 :
            return "Comments"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = .black
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
}



extension CoupleDetailViewController :AddCommentCellDelegate, ChartsViewDelegate {
    
    //MARK: - Add Comments
    func handleSend(text: String, textView: CustomInputTextView) {
        
        guard text != "" else {return}
        guard currentUID() != "" else {return}
        let commentId = UUID().uuidString
        
        self.navigationController?.showPresentLoadindView(true)

        
        let comment = Comment(id: commentId, text: text, date: Date(), userId: currentUID(), couple: couple)
        
        CoupleService.uploadComments(comment: comment, couple: couple) { (error) in
            
            if error != nil {
                self.navigationController?.showPresentLoadindView(false)

                self.showErrorAlert(message: error!.localizedDescription)
                return
            }
            
            textView.text = ""
            
            self.comments.insert(comment, at: 0)
            self.navigationController?.showPresentLoadindView(false)

        }
    }
    
    
    
 
    func showLoadingView() {
        self.navigationController?.showPresentLoadindView(true)
    }
    
    func dismissLoadingView() {
        self.navigationController?.showPresentLoadindView(false)

    }
    
    
}

