//
//  TvItemCell.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

final class TvItemCell: BaseCollectionCell<YsTv> {
    
    static let identifier = String(describing: TvItemCell.self)
    
    private let rootView: UIView = UIView()
    private let tvView: TvView = TvView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(rootView)
        
        rootView.flex
            .direction(.column)
            .define{ flex in
                flex.addItem(tvView)
            }
    }
    
    override func bind(_ model: YsTv) {
        super.bind(model)
        tvView.model = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.height(size.height)
        contentView.flex.layout(mode: .adjustWidth)
        return contentView.frame.size
    }
    
}
