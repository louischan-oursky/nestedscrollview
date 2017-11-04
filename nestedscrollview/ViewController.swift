import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController, UIScrollViewDelegate, ViewPagerDelegate {
    private let viewPager = ViewPager()
    private let scrollViews: [UIScrollView] = [
        MyTableView(),
        MyCollectionView()
    ]

    private let coverShadowView = UIView()
    private let coverView: UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        return v
    }()

    private let profileInfoView = TwitterProfileInfoView()

    private let containerView = UIView()

    private let shadowScrollView = UIScrollView()

    private var observers = [NSKeyValueObservation]()

    private let coverImageHeight: CGFloat = 200
    private var coverShadowTopConstraint: Constraint?
    private var coverImageTopConstraint: Constraint?
    private var currentScrollViewIndex = 0

    private func computeContentSize(scrollViewContentHeight: CGFloat) -> CGSize {
        let width = self.view.bounds.width
        let height = self.coverShadowView.frame.height + self.profileInfoView.frame.height + scrollViewContentHeight
        return CGSize(width: width, height: height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.shadowScrollView)
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.coverView)
        self.containerView.addSubview(self.coverShadowView)
        self.containerView.addSubview(self.profileInfoView)
        self.containerView.addSubview(self.viewPager)
        self.viewPager.views = self.scrollViews
        self.containerView.addGestureRecognizer(self.shadowScrollView.panGestureRecognizer)
        self.viewPager.delegate = self

        self.shadowScrollView.delegate = self
        self.coverShadowView.isHidden = true
        self.shadowScrollView.isHidden = true

        for view in self.scrollViews {
            view.isScrollEnabled = false
            let observer = view.observe(\UIScrollView.contentSize, options: [.new]) { (_, change) in
                let idx = self.scrollViews.index(where: { $0 === view })
                if let idx = idx, idx == self.currentScrollViewIndex {
                    self.shadowScrollView.contentSize = self.computeContentSize(scrollViewContentHeight: change.newValue?.height ?? 0)
                }
            }
            self.observers.append(observer)
        }

        self.coverView.kf.setImage(with: URL(string: "http://cdn.nbcuni.co.jp/justbecause.jp/core_sys/images/main/kv/kv2.jpg"))
        self.containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        self.shadowScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.containerView)
        }
        self.coverView.snp.makeConstraints { make in
            self.coverImageTopConstraint = make.top.equalToSuperview().constraint
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.coverShadowView)
        }
        self.coverShadowView.snp.makeConstraints { make in
            self.coverShadowTopConstraint = make.top.equalToSuperview().constraint
            make.left.right.equalToSuperview()
            make.height.equalTo(self.coverImageHeight)
        }
        self.profileInfoView.snp.makeConstraints { make in
            make.top.equalTo(self.coverShadowView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        self.viewPager.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.profileInfoView.snp.bottom)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY < 0 {
            for view in scrollViews {
                view.setContentOffset(.zero, animated: false)
            }
            self.coverShadowTopConstraint?.update(offset: -contentOffsetY)
            self.coverImageTopConstraint?.update(offset: 0)
        } else if contentOffsetY >= 0 && contentOffsetY <= self.coverImageHeight {
            for view in scrollViews {
                view.setContentOffset(.zero, animated: false)
            }
            self.coverShadowTopConstraint?.update(offset: -contentOffsetY)
            self.coverImageTopConstraint?.update(offset: -contentOffsetY)
        } else {
            self.scrollViews[self.currentScrollViewIndex].setContentOffset(CGPoint(x: 0, y: contentOffsetY - self.coverImageHeight), animated: false)
            self.coverShadowTopConstraint?.update(offset: -self.coverImageHeight)
            self.coverImageTopConstraint?.update(offset: -self.coverImageHeight)
        }
    }

    func viewPager(_ viewPager: ViewPager, didEndSnappingAtPosition position: Int) {
        self.shadowScrollView.delegate = nil

        self.currentScrollViewIndex = position
        self.shadowScrollView.contentSize = self.computeContentSize(
            scrollViewContentHeight: self.scrollViews[self.currentScrollViewIndex].contentSize.height
        )
        if self.shadowScrollView.contentOffset.y >= self.coverImageHeight {
            let contentOffsetY = self.scrollViews[self.currentScrollViewIndex].contentOffset.y
            self.shadowScrollView.setContentOffset(CGPoint(x: 0, y: self.coverImageHeight + contentOffsetY), animated: false)
        }

        self.shadowScrollView.delegate = self
    }
}
