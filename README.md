# booklendar
#### 책 읽기 루틴 만들기에 도움을 주는 캘린더 기반 독서 기록 앱



### 진행 상황

```swift
                                  📍 
기획 |--------------------|--------------------|
```

- Essential 기능 정리를 완료했다.
- Optional 기능의 윤곽을 그렸다.



```swift
         📍
개발 |--------------------|--------------------|
```

- 검색 화면 & API 연동 진행 중 



<br>

## Features

### ⚡️ Essential

> 최초 버전에서 구현할 기능들

- 일별 독서 기록이 가능하다
  - 도서 검색 api를 통한 책 제목/저자/표지 이미지 제공
  - 코멘트 작성 가능
  - 표지 이미지 표시 프레임 모양 선택 가능
- 세가지 형태의 캘린더 뷰를 제공한다
  1. Daily - 표지 / 제목 / 코멘트 (1줄)
  2. Weekly - 표지 / 제목 / 글쓴이 / 코멘트 (3줄)
  3. Monthly - 표지
- 도서 별 코멘트 모아보기를 지원한다
  - 디테일 화면을 통해 코멘트 타임라인으로 넘어갈 수 있다
- iCloud를 통한 데이터 백업이 가능하다
- 설정 창에서 앱 구동 시 가장 먼저 노출할 캘린더 기본 스타일을 지정할 수 있다

<br>

### 🛠 Optional

> 배포 후 업데이트를 통해 지원할 기능들

- 사용자가 읽은 전체 도서 목록을 볼 수 있다
  - 최근 코멘트 순 / ㄱㄴㄷ순 / 최다 코멘트 순
- 날짜, 도서 제목 및 코멘트 검색이 가능하다
- 하루에 여러 권의 독서 기록이 가능하다
- 기간 별 독서 통계 데이터를 차트 형태로 볼 수 있다
- 캘린더의 배경 색상을 변경할 수 있다

<br>

## Scene Flow

![Scene Flow](https://user-images.githubusercontent.com/72188416/133050631-bf3c69e3-73f8-4a1c-9c77-0ab0ec850839.png)

<br>

## Object & Data Flow

![Object & Data Flow](https://user-images.githubusercontent.com/72188416/133535935-ebe60465-dbec-4e7e-86fb-1bfc7cc3283f.png)

