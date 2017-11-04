import UIKit

class MyTableViewCell: UITableViewCell {
    static let id = "cell"
    var myRow: Int? {
        didSet {
            if let myRow = self.myRow {
                self.textLabel?.text = "\(myRow)"
            } else {
                self.textLabel?.text = "nil"
            }
        }
    }
}

class MyTableView:
    UITableView,
    UITableViewDataSource,
    UITableViewDelegate {
    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = UIColor.white
        self.allowsMultipleSelection = false
        self.separatorStyle = .none
        self.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.id)
        self.delegate = self
        self.dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as! MyTableViewCell
        cell.myRow = indexPath.row
        return cell
    }
}
