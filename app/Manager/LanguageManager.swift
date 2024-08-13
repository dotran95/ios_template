//
//  ThemeManager.swift
//  app
//
//  Created by VTIT on 13/8/24.
//

import RxRelay
import RxCocoa

enum Languages: String {
    case en = "en"
    case vi = "vi"
}

class LanguageManager {
    private let appLanguage: BehaviorRelay<Languages>
    private let key = "app_language"
    private let userDefaults = UserDefaults.standard

    static let shared = LanguageManager()
    
    private init() {
        let lang = userDefaults.string(forKey: key) ?? "vi"
        appLanguage = BehaviorRelay<Languages>(value: Languages(rawValue: lang) ?? .vi)
    }
    
    func localized(_ key: String, args: [CVarArg] = []) -> Driver<String> {
        return appLanguage.map { lang in
            return key.localized(lang.rawValue, arguments: args)
        }.asDriver(onErrorJustReturn: key)
    }
    
    func changeLanguage(lang: Languages) {
        appLanguage.accept(lang)
        userDefaults.set(lang.rawValue, forKey: key)
    }
    
}
