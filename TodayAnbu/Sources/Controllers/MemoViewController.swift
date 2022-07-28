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
    let list: [MemoData] = MemoData.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoData", for: indexPath) as? MemoData else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        // MARK: - data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()!
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
        
        //MARK: - layer
        collectionView.collectionViewLayout = layout()
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count:   3)
        groupLayout.interItemSpacing = .fixed(spacing)
        
        // Section
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
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
