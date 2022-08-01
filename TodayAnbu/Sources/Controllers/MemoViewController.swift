//
//  MemoViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/27.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    typealias Item = MemoData
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var list: [MemoData] = MemoData.list
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
extension MemoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        print(">>> selected: \(framework.day)")
    }
}
