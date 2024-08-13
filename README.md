# Project Github (가칭)

- github 사용자 목록 및 특정 사용자의 저장소 목록 확인

## 프로젝트 빌드, 실행방법

```
flutter pub get
flutter run

// 빌드 실패 시
flutter clean
flutter pub get
flutter run
```

## 코드 컨벤션
1. dart 파일명: snake case
2. class명: pascal case


## 구조 설계

- mvvm 패턴을 폴더 구조로부터 파악하고 사용할 수 있도록 provider, repository, model, view, controller 의 폴더를 생성하여 각 파일을 위치시켰습니다.
- 서버로부터 받아오는 데이터 제공 담당으로 provider, 해당 데이터의 가공은 repository, 데이터 객체 정의는 model, view는 ui, controller는 state managment를 각각 담당하도록 하였습니다.
- view는 라우팅이 가능한 페이지만 위치시켰고, 그 외의 widget, layout은 별도의 폴더를 만들었습니다.

## 상태관리로 GetX 선택의 이유

- 과제의 규모와 그 구조를 생각했을 때, 낮은 러닝커브와 비교적 쉬운 구조로 손쉽고 빠르게 상태관리를 할 수 있다는 장점을 가지고 있는 GetX를 선택했습니다. 