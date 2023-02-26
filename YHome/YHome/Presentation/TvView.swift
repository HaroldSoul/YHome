//
//  TvView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

import FlexLayout
import PinLayout
import Kingfisher

final class TvView: BaseBindView<YsTv> {
    
    enum Constants {
        enum Font {
            static let lbContentTitleFont: UIFont = .boldSystemFont(ofSize: SystemConstants.Size.systemDefaultFontSize)
        }
        
        enum Margins {
            static let controlMargin: CGFloat = 4
        }
        
        enum Size {
            static let nameFontSize: CGFloat = 16
            static let titleHeight: CGFloat = 24
            static let ivRoundSize: CGFloat = 8
        }
    }
    
    private let rootView: UIView = UIView()
    private let ivThumbnail: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    private let lbContentTitle: UILabel = UILabel().then {
        $0.font = Constants.Font.lbContentTitleFont
    }
    
    override func setLayout() {
        super.setLayout()

        addSubview(rootView)
        
        rootView.flex
            .direction(.column)
            .height(100%)
            .define{ flex in
                flex.addItem(ivThumbnail)
                    .grow(1)
                    .shrink(1)
                flex.addItem(lbContentTitle)
                    .height(Constants.Size.titleHeight)
                    .marginTop(Constants.Margins.controlMargin)
            }
        
        ivThumbnail.round(Constants.Size.ivRoundSize)
    }
    
    override func bind(_ model: YsTv) {
        lbContentTitle.text = model.tvNameMain
        if let thumbNailURL = URL(string: model.tvFullImgUrl) {
            ivThumbnail.kf.setImage(with: thumbNailURL, placeholder: SystemConstants.images.placeHolder)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        rootView.pin.width(size.width)
        rootView.flex.layout(mode: .fitContainer)
        return rootView.frame.size
    }

}
