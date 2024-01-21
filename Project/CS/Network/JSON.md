---
title: JSON
date: 2024-01-21 18:27
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

## JSON (JavaScript Object Notation)
+ Javascript 객체 문법으로 구조화된 데이터를 표현하기 위한 문자 기반의 표준 포맷이다.
+ 순수히 데이터 포맷으로, 오직 프로퍼티만 담을 수 있으며 메서드는 담을 수 없다.
+ 작은 따옴표는 사용 불가능하다.
+ https://jsonlint.com/ 를 통해 JSON 유효성 검사를 할 수 있다.

## JSON 구조 예시
```javascript
{
  "squadName": "Super hero squad",
  "homeTown": "Metro City",
  "formed": 2016,
  "secretBase": "Super tower",
  "active": true,
  "members": [
    {
      "name": "Molecule Man",
      "age": 29,
      "secretIdentity": "Dan Jukes",
      "powers": ["Radiation resistance", "Turning tiny", "Radiation blast"]
    },
    {
      "name": "Madame Uppercut",
      "age": 39,
      "secretIdentity": "Jane Wilson",
      "powers": [
        "Million tonne punch",
        "Damage resistance",
        "Superhuman reflexes"
      ]
    },
    {
      "name": "Eternal Flame",
      "age": 1000000,
      "secretIdentity": "Unknown",
      "powers": [
        "Immortality",
        "Heat Immunity",
        "Inferno",
        "Teleportation",
        "Interdimensional travel"
      ]
    }
  ]
}

```


