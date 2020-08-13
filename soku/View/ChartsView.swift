//
//  ChartsView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Charts

protocol ChartsViewDelegate : class {
    func showLoadingView()
    func dismissLoadingView()

}

class ChartsView : UIView {
    
    weak var delegate : ChartsViewDelegate?
    
    //MARK: - Propert
    
    let couple : Couple
    
    lazy var goodCount = couple.goodCount
    lazy var badCount = couple.badCount
    

    
    //MARK: - Parts
    
    private var pieChart : PieChartView = {
        let chart = PieChartView(frame: .zero)
        chart.maxAngle = 180
        chart.rotationAngle = 180
        chart.holeColor = .clear
        chart.holeRadiusPercent = 0.56
        chart.dragDecelerationEnabled = false
        chart.legend.textColor = .white
        
        
        //        chart.isUserInteractionEnabled = false
        
        return chart
    }()
    
    private let sadEmojiView : UIImageView = {
        let iv = UIImageView()
        let image = "😭".textToImage()
        iv.image = image
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 40, width: 40)
        
        return iv
    }()
    
    private let goodEmojiView : UIImageView = {
        let iv = UIImageView()
        let image = "🥰".textToImage()
        iv.image = image
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 40, width: 40)
        
        return iv
    }()
    
    init(couple : Couple) {
        self.couple = couple
        super.init(frame: .zero)
        
        print(self.goodCount)
        
        self.backgroundColor = .black
        addSubview(pieChart)
        pieChart.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor, paddingTop: 16,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
        
        configureChartView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        
        //MARK: - UI
        
        private func configureChartView() {
            

//            pieChart.centerText = "テストデータ"
            
            var dateEntries : [PieChartDataEntry]
            
            if goodCount + badCount == 0 {
                
                dateEntries = [PieChartDataEntry(value:100 , label: "投稿がありません")]
            } else {
                dateEntries = [
                    PieChartDataEntry(value: encodeDouble(count: badCount), label: "ショック"),
                    PieChartDataEntry(value: encodeDouble(count: goodCount), label: "お似合い！")
                ]
            }
            
            
            
            let dataSet = PieChartDataSet(entries: dateEntries, label: "")
            
            dataSet.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , .systemPink]
            dataSet.entryLabelColor = .white
            dataSet.valueTextColor = .white

            
            pieChart.data = PieChartData(dataSet: dataSet)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 1
            formatter.multiplier = 1.0
            pieChart.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            
//            addSubview(pieChart)
            
            pieChart.addSubview(sadEmojiView)
            sadEmojiView.anchor(top : topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
            
            pieChart.addSubview(goodEmojiView)
            goodEmojiView.anchor(top : topAnchor,right : rightAnchor,paddingTop: 16,paddingRight: 16)
            
            
        }
    
    //MARK: - helpers
    
    private func encodeDouble(count : Int) -> Double {
        
        let sumVoteCount = goodCount + badCount

        return Double(count / sumVoteCount * 100)
    }
}

extension ChartsView : DetailHeaderViewDelegate {
    func handleLike(header: DetailHeaderView, couple: Couple) {
        
        delegate?.showLoadingView()
        
        CoupleService.uploadVote(coupleId: couple.id, like: true) { (error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            header.disableButton()
            self.goodCount += 1
            self.configureChartView()
            
            self.delegate?.dismissLoadingView()

        }
    }
    
    func handleUnlike(header: DetailHeaderView, couple: Couple) {
        
        delegate?.showLoadingView()

        CoupleService.uploadVote(coupleId: couple.id, like: false) { (error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            header.disableButton()
            self.badCount -= 1
            self.configureChartView()
            
            self.delegate?.dismissLoadingView()


        }

    }
    
    
    
    
}
