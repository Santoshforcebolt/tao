//
//  TaoStoryViewController.swift
//  tao
//
//  Created by Mayank Khursija on 08/06/22.
//

import Foundation
import FloatingPanel

class TaoStoryViewController: BaseViewController<TaoStoryViewModel>, FloatingPanelControllerDelegate {
    private var isScrolledToSelectedIndex = false
    private var storyCollectionView: UICollectionView
    var fpc: FloatingPanelController!
    
    override init(_ viewModel: TaoStoryViewModel) {
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyCollectionViewLayout.scrollDirection = .vertical
        storyCollectionViewLayout.minimumLineSpacing = 0
        storyCollectionViewLayout.minimumInteritemSpacing = 0

        self.storyCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: storyCollectionViewLayout)
        self.storyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setupView()
        
        self.storyCollectionView.delegate = self
        self.storyCollectionView.dataSource = self
        self.storyCollectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: "cell")
        self.storyCollectionView.showsVerticalScrollIndicator = false
        self.storyCollectionView.isPagingEnabled = true
        self.storyCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isScrolledToSelectedIndex == false {
            self.storyCollectionView.scrollToItem(
                at: IndexPath(row: self.viewModel.selectedItemIndex, section: 0),
                at: .centeredVertically,
                animated: false)
            self.isScrolledToSelectedIndex = true
        }
    }
    
    func setupView() {
        self.view.addSubview(self.storyCollectionView)

        self.storyCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.storyCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.storyCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.storyCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                                                         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storyCollectionView.reloadItems(at: [IndexPath(item: self.viewModel.selectedItemIndex,
                                                            section: 0)])
    }
}

extension TaoStoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.mediaEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StoryViewCell ?? StoryViewCell(frame: .zero)
        cell.backgroundColor = .black
        self.viewModel.selectedItemIndex = indexPath.row
        let vm = StoryCellViewModel(mediaEntry: self.viewModel.mediaEntries[indexPath.row])
        vm.viewHandler = BaseViewHandler(presentingViewController: self)
        cell.setup(vm: vm)
        
        if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
            let completelyVisible = collectionView.bounds.contains(cellRect)
            if completelyVisible {cell.startPlayback()}
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemHeight = self.storyCollectionView.frame.height
        let inertialTargetY = targetContentOffset.pointee.y
        let offsetFromPreviousPage = (inertialTargetY + self.storyCollectionView.contentInset.bottom).truncatingRemainder(dividingBy: itemHeight)
        
        // snap to the nearest page
        let pagedY: CGFloat
        if offsetFromPreviousPage > itemHeight / 2 {
            pagedY = inertialTargetY + (itemHeight - offsetFromPreviousPage)
        } else {
            pagedY = inertialTargetY - offsetFromPreviousPage
        }
        
        let point = CGPoint(x: targetContentOffset.pointee.x, y: pagedY)
        targetContentOffset.pointee = point
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = self.storyCollectionView.indexPathsForVisibleItems
            .sorted { top, bottom -> Bool in
                return top.section < bottom.section || top.row < bottom.row
            }.compactMap { indexPath -> UICollectionViewCell? in
                return self.storyCollectionView.cellForItem(at: indexPath)
            }
        let indexPaths = self.storyCollectionView.indexPathsForVisibleItems.sorted()
        let cellCount = visibleCells.count
        guard let firstCell = visibleCells.first as? StoryViewCell, let firstIndex = indexPaths.first else {return}
        self.checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 {return}
        guard let lastCell = visibleCells.last as? StoryViewCell, let lastIndex = indexPaths.last else {return}
        self.checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    
    func checkVisibilityOfCell(cell: StoryViewCell, indexPath: IndexPath) {
        if let cellRect = (self.storyCollectionView.layoutAttributesForItem(at: indexPath)?.frame) {
            let completelyVisible = self.storyCollectionView.bounds.contains(cellRect)
            if completelyVisible {cell.startPlayback()} else {cell.stopPlayback()}
        }
    }
}
