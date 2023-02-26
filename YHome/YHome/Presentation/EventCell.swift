//
//  EventCell.swift
//  YHome
//
//  Created by kangho lee on 2023/02/25.
//

import UIKit

import FlexLayout
import PinLayout
import Then
import Kingfisher
import ReactorKit

final class EventCell: BaseTableViewCell, View {
    
    static let identifier = String(describing: EventCell.self)
    
    typealias Reactor = ReCommandReactor
    
    enum Constants {
        enum Color {
            static let displayNameColor: UIColor = .darkGray
            static let nameColor: UIColor = .black
            static let commentColor: UIColor = .gray
            static let subContentColor: UIColor = displayNameColor
            static let countColor: UIColor = .systemPink
            static let reservationColor: UIColor = SystemConstants.Color.systemDefaultPinkColor
            static let lineColor: UIColor = .lightGray.withAlphaComponent(0.3)
        }
        
        enum Font {
            static let displayNameFont: UIFont = .boldSystemFont(ofSize: SystemConstants.Size.systemDefaultFontSize)
            static let nameFont: UIFont = .boldSystemFont(ofSize: Size.nameFontSize)
            static let commentFont: UIFont = displayNameFont
            static let priceFont: UIFont = .boldSystemFont(ofSize: Size.priceFontSize)
            static let titleFont: UIFont = displayNameFont
            static let countFont: UIFont = displayNameFont
            static let reservationFont: UIFont = .systemFont(ofSize: Size.reservationFontSize)
        }
        
        enum Margins {
            static let cellPadding: CGFloat = 8
            static let viewMargin: CGFloat = 8
            static let controlMargin: CGFloat = 4
        }
        
        enum Size {
            static let nameFontSize: CGFloat = 16
            static let priceFontSize: CGFloat = 18
            static let ivThumbnailSize: CGSize = CGSize(width: 128, height: 128)
            static let fixCellSize: CGFloat = 144
            static let reservationFontSize: CGFloat = 12
            static let reservationWidth: CGFloat = 65
            static let reservationHeight: CGFloat = 25
        }
        
        enum Strings {
            static let wishTitle: String = "관심도"
            static let reviewTitle: String = "리뷰"
            static let scoreTitle: String = "⭑"
            static let reservationTitle: String = " 모바일예약 "
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let rootView: UIView = UIView()
    private let bodyView: UIView = UIView()
    private let ivThumbnail: UIImageView = UIImageView(frame: CGRect(origin: .zero,
                                                                     size: Constants.Size.ivThumbnailSize)).then {
        $0.round(8)
        $0.contentMode = .scaleAspectFit
    }
    private let lbDisplayName: UILabel = UILabel().then {
        $0.font = Constants.Font.displayNameFont
        $0.textColor = Constants.Color.displayNameColor
        $0.numberOfLines = 2
    }
    
    private let btnReservation: UIButton = UIButton(frame: CGRect(origin: .zero,
                                                                  size: CGSize(width: Constants.Size.reservationWidth,
                                                                               height: Constants.Size.reservationHeight))).then{
        $0.backgroundColor = Constants.Color.reservationColor
        $0.setTitle(Constants.Strings.reservationTitle, for: .normal)
        $0.titleLabel?.font = Constants.Font.reservationFont
        $0.round(12)
    }
    
    private let lbName: UILabel = UILabel().then {
        $0.font = Constants.Font.nameFont
        $0.textColor = Constants.Color.nameColor
    }
    
    private let lbComment: UILabel = UILabel().then {
        $0.font = Constants.Font.commentFont
        $0.textColor = Constants.Color.commentColor
        $0.numberOfLines = 0
    }
    
    
    private let lbPrice: UILabel = UILabel().then {
        $0.font = Constants.Font.priceFont
        $0.textColor = Constants.Color.countColor
    }
    
    private let lbWishCountTitle: UILabel = UILabel().then {
        $0.text = Constants.Strings.wishTitle
        $0.font = Constants.Font.titleFont
    }
    
    private let lbWishCount: UILabel = UILabel().then {
        $0.font = Constants.Font.countFont
        $0.textColor = Constants.Color.countColor
    }
    
    private let lbReviewCountTitle: UILabel = UILabel().then {
        $0.font = Constants.Font.titleFont
        $0.text = Constants.Strings.reviewTitle
        
    }
    
    private let lbReviewCount: UILabel = UILabel().then {
        $0.font = Constants.Font.countFont
        $0.textColor = Constants.Color.countColor
    }
    
    
    private let lbScoreTitle: UILabel = UILabel().then {
        $0.font = Constants.Font.titleFont
        $0.text = Constants.Strings.scoreTitle
        
    }
    
    private let lbScore: UILabel = UILabel().then {
        $0.font = Constants.Font.countFont
        $0.textColor = Constants.Color.countColor
    }
    
    override func setLayout() {
        super.setLayout()
        
        let countView: UIView = UIView()
        
        countView.flex
            .direction(.row)
            .alignItems(.end)
            .justifyContent(.end)
            .define{ flex in
                flex.addItem(lbPrice)
                    .grow(1)
                
                flex.addItem(lbWishCountTitle)
                    .marginLeft(Constants.Margins.controlMargin)
                flex.addItem(lbWishCount)
                
                flex.addItem(lbReviewCountTitle)
                    .marginLeft(Constants.Margins.controlMargin)
                flex.addItem(lbReviewCount)
                
                flex.addItem(lbScoreTitle)
                    .marginLeft(Constants.Margins.controlMargin)
                flex.addItem(lbScore)
            }
        
        
        bodyView.flex
            .direction(.column)
            .shrink(1)
            .define{ flex in
                flex.addItem()
                    .direction(.row)
                    .shrink(1)
                    .define{ row in
                        row.addItem(lbDisplayName)
                            .grow(1)
                            .shrink(1)
                        row.addItem(btnReservation)
                            .marginLeft(Constants.Margins.controlMargin)
                            .width(Constants.Size.reservationWidth)
                            .height(Constants.Size.reservationHeight)
                    }
                flex.addItem(lbName)
                    .marginTop(Constants.Margins.controlMargin)
                flex.addItem(lbComment)
                    .marginTop(Constants.Margins.controlMargin)
                flex.addItem(countView)
                    .grow(1)
                    .marginTop(Constants.Margins.controlMargin)
            }
        
        
        
        rootView.flex
            .direction(.row)
            .padding(Constants.Margins.cellPadding)
            .height(Constants.Size.fixCellSize)
            .define{ flex in
                flex.addItem(ivThumbnail)
                    .size(Constants.Size.ivThumbnailSize)
                flex.addItem(bodyView)
                    .grow(1)
                    .marginLeft(Constants.Margins.viewMargin)
            }
        
        contentView.flex
            .direction(.column)
            .define{ flex in
                flex.addItem(rootView)
                flex.addItem()
                    .backgroundColor(Constants.Color.lineColor)
                    .height(0.5)
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbDisplayName.text = ""
        lbName.text = ""
        lbComment.text = ""
        lbPrice.text = ""
        lbReviewCount.text = ""
        lbWishCount.text = ""
        lbScore.text = ""
        ivThumbnail.image = nil
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        contentView.flex.layout(mode: .adjustHeight)
        return contentView.frame.size
    }
 
    
    func bind(reactor: ReCommandReactor) {
        reactor.state
            .map{ $0.recommand }
            .bind{ [weak self] in
                self?.bind($0)
            }.disposed(by: disposeBag)
        
    }
    
    private func bind(_ model: RecommendEvent) {
        lbDisplayName.text = model.displayName
        lbName.text = model.name
        lbComment.text = model.comment.trimmingCharacters(in: .whitespacesAndNewlines)
        
        lbDisplayName.flex.markDirty()
        lbName.flex.markDirty()
        lbComment.flex.markDirty()
        bodyView.flex.markDirty()
        
        lbPrice.text = String(format: "%@%@", Utils.shared.currencyText(model.price), model.currencyName)
        lbReviewCount.text = String(model.reviewCount)
        lbWishCount.text = String(model.wishCount)
        lbScore.text = String(model.score)
        
        lbReviewCount.flex.markDirty()
        lbWishCount.flex.markDirty()
        lbScore.flex.markDirty()
        
        btnReservation.flex.display(model.reservationYn == "Y" ? .flex : .none)
        
        
        if let imageUrl = URL(string: model.thumbnailImageUrl) {
            ivThumbnail.kf.setImage(with: imageUrl, placeholder: SystemConstants.images.placeHolder)
        }
    }
    
}
