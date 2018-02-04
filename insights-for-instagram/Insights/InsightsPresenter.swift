import Foundation
import UIKit

struct InstagramMediaSection {
    let sectionTitle: String
    let instagramMediaViews: [InstagramMediaView]
}

struct InstagramMediaView {
    let likes: String
    let comments: String
    let imageURL: String
}

protocol InstagramMediaPresentation {
    func presentLoadedSections (with items: [[String: Any]])
    func presentNoAccountSections ()
    func presentAlertController(with message: String)
}

class InsightsPresenter: InstagramMediaPresentation {
    
    // MARK: - Properties
    
    weak var viewController: InsightsViewDisplayLogic?
    
    // MARK: - Present fetched media
    
    func presentLoadedSections(with items: [[String: Any]]) {
        var instagramMediaSections = [InstagramMediaSection]()
        for section in items {
            guard let sectionTitle = section["sectionTitle"] as? String,
            let instagramMedias = section["items"] as? [InstagramMedia] else { return }
            var instagramMediaViews = [InstagramMediaView]()
            for item in instagramMedias {
                let itemView = InstagramMediaView(likes: NSLocalizedString("Likes: ", comment: "")+"\(item.likesCount.formattedWithPoint)", comments: NSLocalizedString("Comments: ", comment: "")+"\(item.commentsCount.formattedWithPoint)", imageURL: item.imageUrl)
                instagramMediaViews.append(itemView)
            }
            let instagramMediaSection = InstagramMediaSection(sectionTitle: sectionTitle, instagramMediaViews: instagramMediaViews)
            instagramMediaSections.append(instagramMediaSection)
        }
        let weekday = DataService.weekday()
        viewController?.diplayFetchedMedia(instagramMediaSections: instagramMediaSections, weekday: weekday)
    }
    
    // MARK: - Present no account UI
    
    func presentNoAccountSections() {
        let instagramMediaSections = createPlaceHolderSection()
        viewController?.diplayFetchedMedia(instagramMediaSections: instagramMediaSections, weekday: NSLocalizedString("Weekday.", comment: ""))
    }
    
    private func createPlaceHolderSection() -> [InstagramMediaSection] {
        let item = InstagramMediaView(likes: NSLocalizedString("Likes", comment: ""), comments: NSLocalizedString("Comments", comment: ""), imageURL: "")
        let items = Array(repeating: item, count: 3)
        let instagramItemsSection_0 = InstagramMediaSection(sectionTitle: AppConfiguration.TableViewSections.zero, instagramMediaViews: items)
        let instagramItemsSection_1 = InstagramMediaSection(sectionTitle: AppConfiguration.TableViewSections.one, instagramMediaViews: items)
        let instagramItemsSection_2 = InstagramMediaSection(sectionTitle: AppConfiguration.TableViewSections.two, instagramMediaViews: items)
        return [instagramItemsSection_0, instagramItemsSection_1, instagramItemsSection_2]
    }
    
    // MARK: - Present Alert Controller
    
    func presentAlertController(with message: String) {
        viewController?.diplayFetchMediaFailureAlert(title: AppConfiguration.Messages.somethingWrongMessage, message: message)
    }
}
