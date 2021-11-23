## iOS 커리어 스타터 캠프

### 프로젝트 관리 앱 저장소(캠퍼: 수박, 리뷰어: 쿠마) <br> (2021.10.25. ~ 2021.11.19.)

### 𝞪. 이번 프로젝트를 통해 학습한 것

1. @resultBuilder
    - SwiftUI에서 후행클로저로 생성하는 뷰들이 적절히 상호작용을 하면서 화면을 그려지는 게 이해가 가지 않았었다
    - 예를 들면
      ```swift
      Container {
        Content() 
        Content()
      }
      ```
    - 위와 같은 코드에서 첫번째 Content는 init이후에 따로 사용이 되지 않기 때문에 바로 버려져야 하는데, 뒤에 생성되는 Content가 첫번째 Content와 적절히 상호작용을 하면서 화면에 그려졌고, 이 부분이 납득이 되지 않았다
    - 그래서 아마 LazyVGrid였던 것으로 기억하는데, 얘를 타고 들어가보니 후행클로저에 Attribute처럼 @ViewBuilder라는 게 있었고, 다시 얘를 찾아보니 @resultBuilder를 사용하고 있는 구조체였다
    - 그래서 resultBuilder에 관한 공식문서를 찾아보게 되었는데, 선언적인 방식으로 nested data를 생성하는 문법이라고 했다
    - protocol처럼, 이 속성을 사용하는 타입은 buildBlock이라고 하는 메소드를 반드시 정의해줘야하며, 내용 자체는 sequence의 reduce와 일맥상통한다고 봤다
    - 그리고 이를 채택한 타입은 클로저의 앞에 Attribute처럼 추가해줄 수 있고, 해당 클로저의 바디 안에 있는 내용들은 buildBlock의 인자로 들어가게 된다
      ```swift
        @resultBuilder struct StringBuilder {
          static func buildBlock(_ components: Int...) -> String {
            return components.reduce("") { partialResult, int in
              return partialResult + int.description
            } 
          }
        }
        
       @StringBuilder func oneTwoThree() -> String {
          1
          2
          3
       }
      
       oneTwoThree() //123
      ```
    - 직접 사용한다면 위처럼 짜볼 수 있겠다.

2. ViewBuilder
   - SwiftUI에서는 특히 ViewBuilder라는 @resultBulder가 존재했다
   - 또 특이하게 인자로 받을 수 있는 뷰의 갯수가 최대 10개까지만 정의가 되어있었다
   - 처음에는 VStack, Group 따위가 이를 사용하고 있어서, 공부만 해놓고 ViewBuilder를 직접 사용할 일이 없었는데 추후 커스텀뷰를 작성하게 되면서, 이를 재사용하기 좋게 만들기 위해서 ViewBuilder를 직접 사용해보게 되었다

3. 

| theme | description |
|---|---|
|||



<br>

---

<br>

### 𝞫. 프로젝트를 진행하며 겪었던 고민...

| issue | solution |
|---|---|
| something | something |

<br>

---

<br>

### 𝞈. 남겨진 것들....😅

| remained | hmm...🤔 |
|---|---|
| something | something |
