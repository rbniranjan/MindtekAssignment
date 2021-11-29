//
//  ViewController.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var pagingControl: UIPageControl!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private lazy var viewModel = ContentViewModel()
    public var currentPageIndex : Int = 0

    private let sectionInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.0,
      bottom: 0.0,
      right: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    private func initialSetup() {
        self.activityView.hidesWhenStopped = true
        activityView.startAnimating()
        pagingControl.currentPage = currentPageIndex
        viewModel.loadInitialData { [weak self] value in
            self?.pagingControl.numberOfPages = self?.viewModel.numberOfImageUrl() ?? 0
            self?.tableView.reloadData()
            self?.collectionView.reloadData()
            self?.activityView.stopAnimating()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImageUrl()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        guard let imageUrl = viewModel.urlForIndex(index: indexPath.row) else {
            return cell
        }
        cell.showImage(for: imageUrl)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pagingControl.currentPage = Int(scrollPos)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
        let paddingSpace = sectionInsets.left * (1 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 1
        
         let availableHeight = collectionView.frame.height - (sectionInsets.top + sectionInsets.bottom)

        //let size = collectionView.frame
        print("Size is \(widthPerItem) and height \(availableHeight)")
        return CGSize(width: widthPerItem, height: availableHeight)
     }
     
     // 3
     func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       insetForSectionAt section: Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfContent()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell// as? ContentTableViewCell 
        guard let content = viewModel.contentForIndex(index: indexPath.row) else {
            return cell
        }
        cell.populateInfo(info: content)
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateTable(for: searchText)
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing")
        return true
    }
}

