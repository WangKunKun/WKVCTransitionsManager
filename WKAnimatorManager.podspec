#
#  Be sure to run `pod spec lint WKAnimatorManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #
  s.name         = "WKAnimatorManager"
  s.version      = "0.1.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = "MIT"          # 开源证书
  s.summary      = "VC转场动画管理框架，使用简便，扩充性强，支持左滑动画" # 项目简介

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "整合VC转场代理管理，轻度封装，扩展性强，持左滑动画。欢迎使用~"
  s.homepage     = "https://github.com/WangKunKun" # 你的主页
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.author             = { "Wangkunkun" => "357863248@qq.com" } # 作者信息
  #

  s.source       = { :git => "https://github.com/WangKunKun/WKVCTransitionsManager.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  s.source_files  = "Transitions"
  s.public_header_files = 'Transitions/*.h'
  s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "7.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"




end
