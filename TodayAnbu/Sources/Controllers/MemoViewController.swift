//
//  MemoViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/27.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var list: [MemoData] = []
    typealias Item = MemoData
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    // var list: [MemoData] = MemoData.list
    override func viewDidLoad() {
        super.viewDidLoad()
        list = makeMemoList()
        collectionView.delegate = self
        // MARK: - presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoCell", for: indexPath) as? MemoCell else {
                return nil
            }
            cell.configure(item)
            cell.layer.cornerRadius = 15
            cell.layer.shadowOffset = CGSize(width: 5, height: 5)
            return cell
        })
        // MARK: - data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)

        // MARK: - layer
        collectionView.collectionViewLayout = layout()
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 15
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.5))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 2)
        groupLayout.interItemSpacing = .fixed(spacing)
        // Section
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25)
        section.interGroupSpacing = spacing
        return UICollectionViewCompositionalLayout(section: section)
    }
    func makeMemoList() -> [MemoData] {
        var list: [MemoData] = []
        var dict: [String: String] = [:]
        dict = UserDefaults.standard.value(forKey: "momMemo") as? [String: String] ?? [:]
        let memoDates = [String](dict.keys)
        let memoDescription = [String](dict.values)
        let memoCount: Int = memoDates.count
        for idx in 0 ..< memoCount {
            let strArray = Array(memoDates[idx])
            let dateString = "\(strArray[2])\(strArray[3])월 \(strArray[4])\(strArray[5])일"
            list.append(MemoData(date: String(dateString), description: memoDescription[idx]))
        }
        return list
    }
}
extension MemoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let list: [MemoData] = makeMemoList()
        let framework = list[indexPath.item]
        // navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}
