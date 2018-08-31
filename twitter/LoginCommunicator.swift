//
//  LoginCommunicator.swift
//  twitter
//
//  Created by 舘俊男 on 2018/08/31.
//  Copyright © 2018年 株式会社ストライド. All rights reserved.
//

import Social
import Accounts

struct LoginCommunicator {
  // @escaping = クロージャが関数のスコープ外で保持される可能性があることを示す属性。
  func login(handler: @escaping (Bool) -> ()) {
    // Twitterが利用可能かどうかを確認する
    if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
      handler(false)
      return
    }
    
    // 端末内のアカウントストアを参照
    let store = ACAccountStore()
    let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
    
    // Twitterのアカウント情報へのアクセスをリクエスト
    store.requestAccessToAccounts(with: type, options: nil) { granted, error in
      
      // 承認されなかった場合
      guard granted else {
        handler(false)
        return
      }
      
      // 何らかのエラーがあった場合
      if let _ = error {
        handler(false)
        return
      }
      
      let accounts = store.accounts(with: type)
      
      // 複数あるであろうアカウントの中から最初の一つを取得
      if let account = accounts?.first as? ACAccount {
        // staticなtwitterAccountに保持
        Account.twitterAccount = account
        handler(true)
      }
    }
  }
}
