import UIKit
import SnapKit

class MyCollectionViewCell: UICollectionViewCell {
    static let id = "cell"
    private let titleLabel = UILabel()
    var myItem: Int? {
        didSet {
            if let myItem = self.myItem {
                self.titleLabel.text = "\(myItem)"
            } else {
                self.titleLabel.text = "nil"
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyCollectionView:
    UICollectionView,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = UIColor.white
        self.dataSource = self
        self.delegate = self
        self.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.id)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.bounds.width, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.id, for: indexPath) as! MyCollectionViewCell
        cell.myItem = indexPath.item
        return cell
    }
}
