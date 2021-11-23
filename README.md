## iOS 커리어 스타터 캠프

### 프로젝트 관리 앱 저장소(캠퍼: 수박, 리뷰어: 쿠마) <br> (2021.10.25. ~ 2021.11.19.)

### I. 선택한 기술스택들

<details>
<summary><b>의존성 관리도구</b></summary>

### 의존성 관리도구
   * Swift Package Manager: 1st party라는 점에서 사용하기도 쉬웠고 미래지향적이라는 생각이 들어 가장 먼저 선택하게 되었다
   * Cocoapods: 애는 SwiftLint 때문에, 이것에 대해서만 특별히 예외적으로 사용하게 되었다. 옛날에는 내부적으로 SPM을 쓰고 있는 Mint를 썼지만, 협업을 할 때 Mint가 프로젝트에 의존성을 유지하는 게 아니라 로컬 드라이브에 의존성을 유지해서 이것을 각자 세팅하는 데에 어려움이 있는 사람이 있었고, 이를 도와주느라 원활히 진행되지 못한 경험이 있었다. Mint가 분명 좋기는 하지만, 러닝커브가 있다는 점에서 굳이 이를 선택하기보다는 가장 오래되었고 레퍼런스도 많은, 정말 구관이 명관이라는 생각에... 코코아팟을 통해 SwiftLint를 사용하기로 했다. 앞에 말한 이야기를 통해 미래에도 유지되지 않을까 하는 낙관이 있다.

</details>

<details>
<summary><b>의존성</b></summary>   

1. SwiftLint
    * 휴먼에러를 방지해준다는 점에서 가장 먼저 떠올랐다
    * 일관된 컨벤션 유지할 수 있게 도와줘 코드 가독성에 긍정적인 영향을 주기도 한다
    * 아주 많은 사람들이 사용한다는 점에서 앞으로도 유지될 라이브러리인 것 같다
    * 이걸 생각하고 만든 사람은 진짜 천재가 아닐까 하는 생각이 있다


2. SwiftUI
    * 프로젝트 요구사항이었다. UIKit을 선택할 수도 있었지만, 앞으로 사용할 수 있는 최신기술이었기 때문에 새로운 것을 공부할 수 있는 기회라고 생각하고 도전하게 되었다


3. Combine
    * 이것도 기회가 되면 도전해볼까 싶은 영역이었다
    * 아주 지엽적인 부분에 대해서는 공부를 하고 사용을 했으나, 공부할 게 너무 많다보니 이 부분에 대해서는 제대로 공부를 하진 못해서 많이 아쉬움이 남는다
    * SwiftUI가 내부적으로 이미 Combine을 import 해놓아서 혹시 알게 모르게 썼을지도 모르겠다


4. CoreData
    * 프로젝트에서 사용할 데이터가 key-value의 쌍으로 표현되는 데이터라기보다는,
    * 보다 복잡한 데이터이면 적절히 유지관리가 필요하다는 점에서, 로컬데이터 저장에는 이게 적합해 보인다
    * 또 이에 대해서 예전에 공부를 해본 적이 있었기 때문에 좀 더 만만해 보이는 것도 있었다


5. Alamofire
    * 프로젝트 요구사항이 확장될 때 혹시 네트워킹이 필요하다면 사용해보기로 한 것
    * 쓰게 된다면 한 번 내부를 뜯어보고 사용하려고 했는데 결국 쓸 일은 없었다


6. CloudKit
    * 원격저장소를 쓴다면 평소에 관심이 있어서 써보려고 했으나, 공부만 하다가 끝이 났다

</details>



### II. 이번 프로젝트를 통해 학습한 것

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


3. MVVM
   * MVC는 나이브하게 앱의 구성을 Model, View, Controller로 구분하여 개발 및 유지보수를 쉽게 하려는 목적을 가진 아키텍처였다
   * 그런데 이 경우 Controller가 너무 비대해지는 이슈가 있었다. 이에 대한 해결책으로 나온 것이 MVVM이다
   * 그러면 이를 어떻게 해결했는가? 왜 Controller가 비대해졌는가?
     * MVC는 event driven 되기 때문에 컨트롤러가 뷰에 대해 해줘야할 일이 너무 많았고, 이에 따라 모델에 반영할 일이 생기면 이것도 해야해서 할 게 너무 많았다. 게다가 뷰는 때에 따라 각각의 이벤트에 따른 상태를 유지할 필요도 있었다
     * 심지어 Controller를 적절히 쪼개지 않아 Controller가 너무 많은 View를 알고 있을 경우에는, Controller가 기하급수적으로 비대해졌다
   * MVVM은 먼저 event driven되지 않고 data driven이 되도록 한다. 각각의 뷰는 그림처럼 그저 표현될 뿐이다. 누구도 뷰에게 명령을 하지 않는다
     * 명령의 주체인 컨트롤러라는 게 필요가 없어진다
     * 즉 MVVM을 사용하는 이유는 기존의 event driven 방식에서 발생하는 상태에 따른 코드들을, data driven 방식으로 대체하면서 사용하지 않겠다는 말과 같다
   * ViewModel은 View와 Model 사이에서 데이터를 조작해서 주고 받게 해준다. 때문에 Interpreter라고도 표현한다고 한다
   * 즉 모든 동작은 ViewModel이 하게 되지만, View는 이에 대한 결과로써 단지 보여질 뿐이다


4. MVVM + Combine
   * 풀어나가야할 단어를 일단 정리를 해봤다. Source of truth, ObservableObject, StateObject, ObservedObject, objectWillChange.send(), Publisher...
   * 


| theme | description |
|---|---|
|||



<br>

---

<br>

### III. 프로젝트를 진행하며 겪었던 고민...

| issue | solution |
|---|---|
| something | something |

<br>

---

<br>

### IV. 남겨진 것들....😅

| remained | hmm...🤔 |
|---|---|
| something | something |
