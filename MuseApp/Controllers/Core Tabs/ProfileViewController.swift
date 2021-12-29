//
//  ProfileViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Profile Photo
    
    // Full Name
    
    // Email Address
    
    // List of Posts
    
    private var user: User?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let currentEmail: String
    
    init(currentEmail: String){
        self.currentEmail = currentEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSignOutButton()
        setupTable()
        title = "Profile"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupTableHeader()
        fetchProfileData()
    }
    
    private func setupTableHeader(profilePhotoURLRef: String? = nil, name: String? = nil){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        headerView.backgroundColor = .systemBlue
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        tableView.tableHeaderView = headerView
        
        // Profile Pict
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.width-(view.width/4))/2,
                                    y: (headerView.height-(view.width/4))/2.5,
                                    width: view.width/4,
                                    height: view.width/4)
        profilePhoto.isUserInteractionEnabled = true
        headerView.addSubview(profilePhoto)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto))
        profilePhoto.addGestureRecognizer(tap)
        
        // Email
        
        let emailLabel = UILabel(frame: CGRect(x: 20, y: profilePhoto.bottom+10, width: view.width-40, height: 100))
        headerView.addSubview(emailLabel)
        emailLabel.textColor = .white
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        
        // Name
        if let name = name{
            title = name
        }
        
        if let ref = profilePhotoURLRef{
            // Fetch image
            
            StorageManager.shared.getProfilePictureURL(path: ref) { url in
                guard let url = url else {
                    return
                }
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        profilePhoto.image = UIImage(data: data)
                    }
                    
                }.resume()

            }
            
        }
    }
    
    
    @objc private func didTapProfilePhoto(){
        
        guard let myEmail = UserDefaults.standard.string(forKey: "email"),
        myEmail == currentEmail else{
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    private func fetchProfileData(){
        
        DatabaseManager.shared.getUser(email: currentEmail) {[weak self] user in
            guard let user = user else{
                return
            }
            self?.user = user
            DispatchQueue.main.async {
                self?.setupTableHeader(profilePhotoURLRef: user.profilePictureUrlReference, name: user.name)
            }
        }
        
    }
    
    private func setupSignOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
    }
    
    /// Sign Out
    @objc private func didTapSignOut(){
        
        let alertSheet = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success{
                    DispatchQueue.main.async {
//                        reset userdefaults upon sign out
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")

                        let signinVC = SignInViewController()
                        signinVC.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVC = UINavigationController(rootViewController: signinVC)
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: nil)
                    }
                }
            }
            
        }))
        present(alertSheet, animated: true, completion: nil)
        
    }

     //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Blog Post Goes Here"
        return cell
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else{
            return
        }
        
        StorageManager.shared.uploadUserProfilePicture(email: currentEmail,
                                                       image: image) { [weak self] success in
            
            guard let strongSelf = self else{
                return
            }
            
            if success{
                //updare DB
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                  
                    guard updated else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.fetchProfileData()
                    }
                    
                    
                }
                
                
                
            }else{
                
                
            }
            
        }
        
    }
    
}
