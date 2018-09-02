//
//  ViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/15/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController {

    @IBOutlet weak var profilesCollectionView: UICollectionView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var filterSortButton: UIButton!
    @IBOutlet weak var filterSortLabel: UILabel!
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLogin()
        profileViewModel.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.PRESENT_LOGIN_SEGUE:
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.delegate = self
            }
        case Constants.PRESENT_FILTER_SORT_SEGUE:
            if let filterSortController = segue.destination as? FilterSortViewController {
                filterSortController.delegate = self
            }
        case Constants.PRESENT_PROFILE_DETAIL_SEGUE:
            
            if let detailViewController = segue.destination as? ProfileDetailViewController,
                let selectedCell = sender as? ProfileCollectionViewCell,
                let selectedProfile = selectedCell.profile {
                
                detailViewController.selectedProfile = selectedProfile
            }
        default:
            break
        }
        
    }

    private func presentLogin() {
        performSegue(withIdentifier: Constants.PRESENT_LOGIN_SEGUE, sender: self)
    }
    
    @IBAction func clearFilterSortButtonTapped() {
        profileViewModel.getProfiles(filteredBy: nil, value: nil)
        filterSortLabel.text = "No filters or sorting selected"
    }
}

// MARK: - Login View Delegate

extension ProfilesViewController : LoginViewDelegate {
    func loginDidSucceed() {
        
        dismiss(animated: true) {
        }
        
        profileViewModel.getProfiles(filteredBy: nil, value: nil)
    }
    
    func logingDidFail() {
        // TODO
    }
}

// MARK: - Profile ViewModel Delegate
extension ProfilesViewController : ProfileViewModelDelegate {
    func profilesChanged() {
        profilesCollectionView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Filter & Sort View Delegate
extension ProfilesViewController : FilterSortViewDelegate {
    func filterSelectionMade(_ filterSelection: String) {
        profileViewModel.filterProfiles(byGender: filterSelection)
        
        filterSortLabel.text = "Filtered by \(filterSelection)"
    }
    
    func sortSelectionMade(_ sortSelection: ProfileSortType) {
        profileViewModel.sortProfiles(sortSelection)
        
        filterSortLabel.text = "Sorted by \(sortSelection.rawValue)"
    }
}

// MARK: - Collection View Delegate & Datasource

extension ProfilesViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let profile = profileViewModel.profiles[indexPath.row]
        cell.profile = profile
        
        cell.nameLabel.text = profile.getFirstNameLastName()
        cell.ageLabel.text = String(profile.age)
        cell.hobbiesLabel.text = profile.hobbies.description
        cell.genderLabel.text = profile.gender
        
        if let image = profileViewModel.loadImage(fromUrl: profile.profilePicture) {
            cell.profileImageView.image = image
        }
        
        switch profile.gender {
        case "female":
            cell.backgroundColor = Constants.PINK_COLOR
            break
        case "male":
            cell.backgroundColor = Constants.BLUE_COLOR
            break
        default:
            cell.backgroundColor = Constants.GREEN_COLOR
            break
        }
        
        return cell
    }
    
}
