//
//  TvCell.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

import FlexLayout
import PinLayout
import ReactorKit
import RxSwift
import RxDataSources

final class TvCell: BaseTableViewCell, View {
    typealias Reactor = TvReactor
    
    static let identifier = String(describing: TvCell.self)
    var disposeBag: DisposeBag = DisposeBag()

    
    enum Constants {
        enum Margins {
            static let cellMargin: CGFloat = 8
        }
        
        enum Size {
            static let rootCellSize: CGFloat = 144
            static let fixCellSize: CGFloat = 128
        }
    }
    
    private let rootView: UIView = UIView()
    private var collectionView: UICollectionView!
    
    internal override func setLayout() {
        contentView.addSubview(rootView)
        
        collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.register(TvItemCell.self,
                    forCellWithReuseIdentifier: TvItemCell.identifier)
        
        rootView.flex
            .direction(.column)
            .define { flex in
                flex.addItem(collectionView)
                    .height(Constants.Size.rootCellSize)
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        contentView.flex.layout(mode: .adjustHeight)
        return contentView.frame.size
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: frame.width / 2 , height: Constants.Size.fixCellSize)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: Constants.Margins.cellMargin,
                                        left: Constants.Margins.cellMargin,
                                        bottom: Constants.Margins.cellMargin,
                                        right: Constants.Margins.cellMargin)
        
        return flowLayout
    }
}

extension TvCell {
    func bind(reactor: TvReactor) {
        reactor.state
            .map{ $0.tvs }
            .bind(to: collectionView.rx.items(cellIdentifier: TvItemCell.identifier,
                                              cellType: TvItemCell.self)){
                index, item, cell in
                cell.model = item
            }.disposed(by: disposeBag)
    }
}

