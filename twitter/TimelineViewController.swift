//
//  TimelineViewController.swift
//  twitter
//
//  Created by 舘俊男 on 2018/08/28.
//  Copyright © 2018年 株式会社ストライド. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var tweets: [Tweet] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()

      // ダミーデータの生成
      let user = User(json: "1"
        // , screenName: "noritama241"
        // , name: "たちつてと"
        // , profileImageURL: "https://pbs.twimg.com/profile_images/585445502117752832/tPMOrjCr_400x400.jpg"
      )
      let tweet = Tweet(id: "01", text: "超元気", user: user!)
      
      let tweets = [tweet]
      self.tweets = tweets
      
      // tableViewのリロード
      tableView.reloadData()
      
        // Do any additional setup after loading the view.
      tableView.delegate = self as? UITableViewDelegate
      
      tableView.dataSource = self
      
      LoginCommunicator().login() { isSuccess in
        switch isSuccess {
        case false:
          print("ログイン失敗")
        case true:
          print("ログイン成功")
          
          TwitterCommunicator().getTimeline() { [weak self] data, error in
            
            if let error = error {
              print(error)
              return
            }
            
            print(data)
            let timelineParser = TimelineParser()
            let tweets = timelineParser.parse(data: data!)
            
            print(tweets)
            
            self?.tweets = tweets
            
            DispatchQueue.main.async {
              self?.tableView.reloadData()
            }

          }
        }
      }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimelineViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    print("セルがタップされたよ")
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

extension TimelineViewController: UITableViewDataSource {
  // 何個のcellを生成するかを設定する関数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // tweetsの配列内の要素数分を指定
    return tweets.count
  }
  
  // 描画するcellを設定する関数
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // TweetTableViewCellを表示したいので、TweetTableViewCellを取得
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
    
    return cell
  }
}
