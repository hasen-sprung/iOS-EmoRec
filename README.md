## CANVAS 다운로드
<p float"left>
  <a href="https://apps.apple.com/kr/app/id1596669616">
    <img src="https://user-images.githubusercontent.com/20364535/147945401-1a372903-becb-4cd8-af0c-15ebf9ce4858.png" width="250" height="250" style="border-radius:50%">
  </a>
</p>

> **"순간 순간의 감정을 그림으로 기록하세요"** <br/><br/>
> **개발 기간 :  21.08.27 ~ 21.12.01** <br/><br/>
> **팀 소개 : [박준홍](https://github.com/feldblume5263), [이재영](https://github.com/ejei0g)**

<br/>

## 프로젝트 소개

<p float"left>

<img height="200" src="https://user-images.githubusercontent.com/20364535/148074891-b98b2ae9-0ebc-4cc0-8118-b7eb75a2e856.jpeg">
<img height="200" src="https://user-images.githubusercontent.com/20364535/148074914-416d5853-139c-4f05-af22-d6d96774e9dd.jpeg">
<img height="200" src="https://user-images.githubusercontent.com/20364535/148074922-95d41586-6873-4185-b1a3-42cc3e642973.jpeg">
<img height="200" src="https://user-images.githubusercontent.com/20364535/148074938-2ad4dbe0-4bea-4e0b-884d-a4485c17e465.jpeg">

</p>
<br/>

## 개발환경 및 라이브러리
![swift](https://img.shields.io/badge/swift-5.0-orange)
![xcode](https://img.shields.io/badge/Xcode-13.2-blue)
![firebase](https://img.shields.io/badge/Firebase-8.9.0-red)
![snapkit](https://img.shields.io/badge/SnapKit-5.0.1-yellow)

<br/>

## 프로젝트 Feature

#### DB
- CoreData : CoreData프레임워크를 사용하여 SQLite 파일을 관리<br/>
<br/>
#### Canvas 화면
- 사용자의 하루 단위(혹은 최근 10개 기록단위)를 모은 그림을 카드 형식으로 한장씩 넘겨가면서 보여주는 Custom CollectionView<br/>
- Animation 처리된 도형 (평상시/Shake 기능을 통해 흔들었을 때)<br/>
- 현재 그림의 기록을 최신순으로 넘겨볼 수 있는 Info모듈<br/>
<br/>
#### 기록 화면
- 게이지 조작부터 기록 작성 완료까지 물 흐르듯이 간편한 사용자 경험 Flow<br/>
- 현재 사용자의 감정을 UIPangesutre와 Animation을 통해 입력하는 GaugeView<br/>
- 날짜, 시간 수정 모듈<br/>
<br/>
#### 일기장 
- 쌓인 기록들을 날짜순, 시간순으로 보여주는 Custom TableView<br/>
- 기록으로 바로가기 기능을 지원하는 Calandar 모듈<br/>
- 안전하고 간편한 삭제가 가능한 Cell<br/>
<br/>

## 아키텍쳐
- MVC Design Pattern
- Delegate Pattern
<br/>

## 고민했던 부분, 기술적 도전
- 사용자 UX 개선을 위해 게이지와 애니메이션을 활용해서 Gauge Custom View 개발 [🔗](https://github.com/hasen-sprung/iOS_Canvas/wiki/gauge-view-prototype)
- 기존에 사용했던 애니메이션 라이브러리를 애플에서 제공하는 기본 클래스(UIViewPropertyAnimator)를 사용해서 리펙토링
- UIKit 기반 앱에서 WidgetKit을 사용해서 위젯 개발 [🔗](https://jaeylee.notion.site/Set-Widget-in-UIkit-based-App-351d26d3fc38455093a8864581d79e41)
<br/>

## 문제 해결 및 개선 사례
- 애니메이션 교체 후 Repeat 부분에서 발생했던 CPU 사용량을 70%에서 10%로 개선 [🔗](https://jaeylee.notion.site/UIViewPropertyAnimator-43fa9b329a174650b59cd14e4d9e84f7)
- 위젯 개발 시, CoreData, UserDefault 데이터 공유를 위해 AppGroup 사용 [🔗](https://jaeylee.notion.site/Get-Data-in-CoreData-2ab732209eaf4fb496d71211625b53fd)
- 키보드 중첩 문제를 Notification과 오토레이아웃 Constraints를 사용해서 해결 [🔗](https://jaeylee.notion.site/SnapKit-and-Keyboard-10f5520be1e642a98e875a7cec304b1d)
- iPhone 8, mini, SE에서 발생한 뷰 충돌 문제를 오토레이아웃 Constraints로 해결
- 코코아팟에서 SPM으로 변경시 발생했던 에러 처리 [🔗](https://jaeylee.notion.site/SPM-Delete-CocoaPods-06bb2700857843cea9c29ac384ab0107)
<br/>

## How We Develop (문서화, 회의록, 개발 일지)
[wiki 바로가기](https://github.com/hasen-sprung/iOS-EmoRec/wiki)
