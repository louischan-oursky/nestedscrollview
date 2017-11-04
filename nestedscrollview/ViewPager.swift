import UIKit
import SnapKit

protocol ViewPagerDelegate: class {
    func viewPager(_ viewPager: ViewPager, didEndSnappingAtPosition position: Int)
}

class ViewPager: UIView, UIScrollViewDelegate {
    weak var delegate: ViewPagerDelegate?

    var views: [UIView]? {
        didSet {
            for view in self.stackView.arrangedSubviews {
                view.removeFromSuperview()
            }
            if let views = self.views {
                for view in views {
                    self.stackView.addArrangedSubview(view)
                    view.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview()
                        make.width.equalTo(self)
                    }
                }
            }
        }
    }

    private let spacing: CGFloat = 0
    private let scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = self.spacing
        return v
    }()

    init() {
        super.init(frame: .zero)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.scrollView.backgroundColor = UIColor(white: 0.5, alpha: 1)
        self.scrollView.isPagingEnabled = true

        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(self)
            make.left.right.equalToSuperview()
        }
        self.scrollView.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x / scrollView.bounds.width
        let positionInt = Int(position)
        self.delegate?.viewPager(self, didEndSnappingAtPosition: positionInt)
    }
}
